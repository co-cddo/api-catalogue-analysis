# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonDataCollector, type: :service do
  let(:data) do
    {
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      url: Faker::Internet.url(host: 'example.com'),
      contact: Faker::Internet.email,
      organisation: Organisation.names.sample,
      'documentation-url': Faker::Internet.url(host: 'example.com')
    }.stringify_keys
  end
  let(:json) do
    {
      apis: [
        {
          'api-version': 'api.gov.uk/v1alpha',
          data:
        }.stringify_keys
      ]
    }.stringify_keys.to_json
  end

  describe '#metadata' do
    subject(:metadata) { described_class.new(data).metadata }

    it 'returns a hash with the fields matching the CSV data' do
      expect(metadata).to be_a(Hash)
      expect(metadata.keys).to contain_exactly('name', 'description', 'url', 'maintainer', 'provider', 'documentation')
    end

    it "doesn't change some fields" do
      expect(metadata['name']).to eq(data['name'])
      expect(metadata['description']).to eq(data['description'])
      expect(metadata['url']).to eq(data['url'])
    end

    it 'changes contact to maintainer' do
      expect(metadata['maintainer']).to eq(data['contact'])
    end

    it 'changes organisation to provider' do
      expect(metadata['provider']).to eq(data['organisation'])
    end

    it 'changes documentation-url to documentation' do
      expect(metadata['documentation']).to eq(data['documentation-url'])
    end
  end

  describe '.call' do
    it 'reads the data from a path and returns an array of metadata' do
      file = Tempfile.new('test.json')
      file.write json
      file.close
      output = described_class.call(file.path)
      expect(output).to be_a(Array)
      expect(output.first).to eq(described_class.new(data).metadata)
      file.unlink
    end
  end
end
