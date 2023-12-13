# frozen_string_literal: true

require 'csv'

class CsvCreator
  def self.call(filename, hashes)
    CSV.open(filename, 'w') do |csv|
      headers = hashes.first.keys
      csv << headers
      hashes.each do |row|
        csv << row.values_at(*headers)
      end
    end
  end
end
