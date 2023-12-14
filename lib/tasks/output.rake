# frozen_string_literal: true

namespace :output do
  desc "Creates a set of CSV files from item data"
  task csv: [:environment] do
    Item.find_in_batches(batch_size: 18).with_index do |items, index|
      hashes = items.map { |item| CsvMapper.call(item) }
      filename = Rails.root.join("tmp", "csv_output_#{index}.csv")
      CsvCreator.call(filename, hashes)
    end
  end
end
