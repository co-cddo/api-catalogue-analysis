require 'rails_helper'

RSpec.describe MetadataMapper, type: :service do
  let(:item) { create :item }
  subject(:metadata_mapper) { described_class.new(item) }

  describe 'metadata' do
    let(:expected) do
      {
        contactPoint: item.maintainer,
        created: item.start_date,
        description: item.description,
        endpointDescription: item.documentation,
        endpointURL: item.url,
        issued: item.date_added,
        licence: item.license,
        modified: item.date_updated,
        publisher: item.provider,
        title: item.name
      }
    end

    it "matches the expected hash" do
      expect(metadata_mapper.metadata).to eq(expected)
    end

    context 'with an empty item' do
      let(:item) { Item.new }

      it "returns a hash with no values" do
        expect(metadata_mapper.metadata).to be_a(Hash)
        expect(metadata_mapper.metadata.compact).to be_blank
      end
    end
  end

  describe 'required_fields_present' do
    let(:expected) do
      [
        :contactPoint,
        :description,
        :endpointDescription,
        :licence,
        :modified,
        :publisher,
        :title
      ]
    end

    it "matches the number of metadata fields that match required fields" do
      expect(metadata_mapper.required_fields_present).to eq(expected)
    end
  end

end
