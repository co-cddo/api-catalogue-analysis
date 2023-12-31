# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Item.delete_all

def create_items(data)
  data.collect do |datum|
    item = Item.new(datum)
    mapper = MetadataMapper.new(item)
    item.metadata = mapper.metadata
    item.number_required = mapper.required_fields_present.size
    item.save!
  end
end

require 'csv'
header_converter = proc { |header| header.underscore.to_sym }
csv_data = CSV.read(Rails.root.join('data/catalogue.csv'), headers: true, header_converters: header_converter)
create_items(csv_data)

# Gather JSON data
%w[dwp food-standards-agency nhs-digital].each do |name|
  path = "data/json/#{name}/apis"
  json_data = JsonDataCollector.call(path)
  create_items(json_data)
end

puts "There are now #{Item.count} items in the database"
