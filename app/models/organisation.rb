# frozen_string_literal: true

class Organisation
  SOURCE_PATH = Rails.root.join('data/uk-gov-orgs.yaml')
  DEFAULT = 'central-digital-and-data-office'

  class << self
    def data
      @data ||= YAML.load_file(SOURCE_PATH, permitted_classes: [Date])
    end

    def names
      data.dig('enums', 'OrganisationValues', 'permissible_values').keys
    end
  end
end
