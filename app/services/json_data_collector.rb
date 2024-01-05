# frozen_string_literal: true

class JsonDataCollector
  KEY_TRANSFORMATION = {
    'contact' => 'maintainer',
    'organisation' => 'provider',
    'documentation-url' => 'documentation'
  }.freeze

  def self.call(path)
    input = JSON.load_file(path)
    apis = input['apis']
    apis.map { |api| new(api['data']).metadata }
  end

  attr_reader :item_hash

  def initialize(item_hash)
    @item_hash = item_hash
  end

  def metadata
    @metadata ||= item_hash.transform_keys(KEY_TRANSFORMATION)
  end
end
