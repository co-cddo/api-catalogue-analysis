# frozen_string_literal: true

require 'rails_helper'
require 'fakefs/safe'

RSpec.describe CsvCreator, type: :service do
  subject(:csv) { described_class.call(filename, hashes) }
  let(:filename) { 'test.csv' }
  let(:hashes) do
    [
      { a: 1, b: 2 },
      { a: 2, b: 3 }
    ]
  end
  let(:lines) { File.readlines(filename) }

  around(:example) do |example|
    FakeFS.with_fresh do
      example.run
    end
  end

  it 'contains three lines (header + two data lines)' do
    csv
    expect(lines.length).to eq(3)
  end

  it 'has a first line made from the keys' do
    csv
    expect(lines.first.chomp).to eq('a,b')
  end

  it 'has a line for each hashes values' do
    csv
    expect(lines[1].chomp).to eq('1,2') # using chomp as each line includes end of line characters
    expect(lines[2].chomp).to eq('2,3')
  end
end
