
class MetadataMapper
  # UK Cross-Government Metadata Exchange Model - Class: DataService
  # https://co-cddo.github.io/ukgov-metadata-exchange-model/DataService/
  METADATA_FIELDS = {
    accessRights: {
      requirement: :required ,
      item_field: nil
    },
    alternativeTitle: {
      requirement: :recommended ,
      item_field: nil
    },
    contactPoint: {
      requirement: :required ,
      item_field: :maintainer
    },
    created: {
      requirement: nil ,
      item_field: :start_date
    },
    creator: {
      requirement: :required ,
      item_field: nil
    },
    description: {
      requirement: :required ,
      item_field: :description
    },
    endpointDescription: {
      requirement: :required ,
      item_field: :documentation
    },
    endpointURL: {
      requirement: nil ,
      item_field: :url
    },
    identifier: {
      requirement: :required ,
      item_field: nil
    },
    issued: {
      requirement: nil ,
      item_field: :date_added
    },
    keyword: {
      requirement: nil ,
      item_field: nil
    },
    licence: {
      requirement: :required ,
      item_field: :license
    },
    modified: {
      requirement: :required ,
      item_field: :date_updated
    },
    publisher: {
      requirement: :required ,
      item_field: :provider
    },
    relatedResource: {
      requirement: :recommended ,
      item_field: nil
    },
    securityClassification: {
      requirement: nil ,
      item_field: nil
    },
    servesData: {
      requirement: nil ,
      item_field: nil
    },
    serviceStatus: {
      requirement: :recommended ,
      item_field: nil
    },
    serviceType: {
      requirement: :required ,
      item_field: nil
    },
    summary: {
      requirement: :recommended ,
      item_field: nil
    },
    theme: {
      requirement: :recommended ,
      item_field: nil
    },
    title: {
      requirement: :required ,
      item_field: :name
    },
    type: {
      requirement: :required ,
      item_field: nil
    },
    version: {
      requirement: :required ,
      item_field: nil
    }
  }

  class << self
    def required_fields
      @required_fields ||= METADATA_FIELDS.select { |_k, v| v[:requirement] == :required }.keys
    end

    def recommended_fields
      @recommeneded_fields ||= METADATA_FIELDS.select { |_k, v| v[:requirement] == :recommended }.keys
    end

    def item_fields
      @item_field ||= METADATA_FIELDS.select { |_k, v| v[:item_field].present? }.keys
    end
  end

  attr_reader :item
  def initialize(item)
    @item = item
  end

  def metadata
    @metadata ||= self.class.item_fields.each_with_object({}) do |field, hash|
      hash[field] = item.send(METADATA_FIELDS.dig(field, :item_field))
    end
  end

  def required_fields_present
    metadata.slice(*self.class.required_fields).compact.keys
  end
end

