# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Item.delete_all
require 'csv'
header_converter = proc { |header| header.underscore.to_sym }
data = CSV.read(Rails.root.join('data/catalogue.csv'), headers: true, header_converters: header_converter)
items = data.collect { |datum| Item.create!(datum) }

puts "There are now #{items.size} items in the database"
