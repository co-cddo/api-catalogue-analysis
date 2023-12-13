# frozen_string_literal: true

# Tool that takes an item and from it creates a hash that matches the data structure of the data-marketplace app input spreadsheet
class CsvMapper
  # data-marketplace app data structure
  CSV_FIELDS = {
    title: {
      requirement: :required,
      item_field: :name
    },
    alternativeTitle: {
      requirement: :recommended,
      item_field: nil
    },
    summary: {
      requirement: :recommended,
      item_field: nil
    },
    description: {
      requirement: :required,
      item_field: :description
    },
    keyword: {
      requirement: :optional,
      item_field: nil
    },
    theme: {
      requirement: :recommended,
      item_field: nil
    },
    contactPoint_contactName: {
      requirement: :required,
      item_field: nil
    },
    contactPoint_email: {
      requirement: :required,
      item_field: :maintainer
    },
    publisher: {
      requirement: :required,
      item_field: :provider
    },
    creator: {
      requirement: :required,
      item_field: :provider
    },
    version: {
      requirement: :required,
      item_field: nil
    },
    issued: {
      requirement: :recommended,
      item_field: :date_added
    },
    modified: {
      requirement: :required,
      item_field: :date_updated
    },
    created: {
      requirement: :optional,
      item_field: :date_added
    },
    licence: {
      requirement: :recommended,
      item_field: :license
    },
    accessRights: {
      requirement: :required,
      item_field: nil
    },
    securityClassification: {
      requirement: :required,
      item_field: nil
    },
    identifier: {
      requirement: :required,
      item_field: nil
    },
    relatedResource: {
      requirement: :recommended,
      item_field: nil
    },
    serviceType: {
      requirement: :required,
      item_field: nil
    },
    serviceStatus: {
      requirement: :required,
      item_field: nil
    },
    endpointURL: {
      requirement: :optional,
      item_field: :url
    },
    endpointDescription: {
      requirement: :required,
      item_field: :documentation
    },
    servesData: {
      requirement: :recommended,
      item_field: nil
    }
  }.freeze

  DEFAULT_EMAIL = 'unknown@example.com'
  DEFAULT_CONTACT_NAME = 'unknown'
  EMAIL_PATTERN = /[\w\-.]+@([\w-]+\.)+[\w-]+/
  DEFAULTS = {
    version: '1',
    accessRights: 'INTERNAL',
    securityClassification: 'OFFICIAL',
    serviceType: 'REST',
    serviceStatus: 'LIVE',
    endpointDescription: 'http://example.com/unknown',
    licence: 'https://creativecommons.org/licenses/by/4.0/'
  }.freeze

  def self.call(item)
    new(item).row
  end

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def row
    process_contact_point
    add_identifier
    output
  end

  private

  def process_contact_point
    maintainer = item.maintainer

    name, email = case maintainer
                  when /^#{EMAIL_PATTERN}$/ # only email present
                    [
                      maintainer.split('@').first,
                      maintainer
                    ]
                  when EMAIL_PATTERN # email within other text
                    email = maintainer[EMAIL_PATTERN]
                    [
                      maintainer.sub(email, '').split(/\W+/).join(' '),
                      email
                    ]
                  else
                    [
                      (maintainer.presence || DEFAULT_CONTACT_NAME),
                      DEFAULT_EMAIL
                    ]
                  end
    output[:contactPoint_contactName] = name
    output[:contactPoint_email] = email
  end

  def add_identifier
    output[:identifier] = SecureRandom.uuid
  end

  def output
    @output ||= CSV_FIELDS.each_with_object(initial_row) do |(key, details), hash|
      hash[key] = details[:item_field].present? ? (item.send(details[:item_field]).presence || hash[key]) : hash[key]
    end
  end

  def initial_row
    # Building from CSV_FIELDS to set key order
    empty_hash_with_csv_fields_keys = CsvMapper::CSV_FIELDS.keys.index_with { nil }
    empty_hash_with_csv_fields_keys.merge(DEFAULTS)
  end
end
