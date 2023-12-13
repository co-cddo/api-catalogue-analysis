# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Item.delete_all
require 'csv'
header_converter = proc { |header| header.underscore.to_sym }
data = CSV.read(Rails.root.join('data/catalogue.csv'), headers: true, header_converters: header_converter)
items = data.collect do |datum|
  item = Item.new(datum)
  mapper = MetadataMapper.new(item)
  item.metadata = mapper.metadata
  item.number_required = mapper.required_fields_present.size
  item.api_status = item.api_response.status if item.url.present?
  item.save!
end

puts "There are now #{items.size} items in the database"
