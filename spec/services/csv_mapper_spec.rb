# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvMapper, type: :service do
  subject(:row) { described_class.call(item) }
  let(:item) { build :item }

  describe '.call' do
    let(:empty_columns) do
      %i[alternativeTitle summary keyword theme relatedResource servesData]
    end

    it 'has a title from the item name' do
      expect(row[:title]).to eq(item.name)
    end

    it 'has keys for each of the empty columns' do
      expect(empty_columns - row.keys).to be_empty
    end

    it 'has a nil entry for each empty columns' do
      values = row.slice(*empty_columns).values
      expect(values.length).to eq(empty_columns.length)
      expect(values.uniq).to eq([nil])
    end

    it 'has a description from the item description' do
      expect(row[:description]).to eq(item.description)
    end

    context 'when description includes line breaks' do
      let(:item) { build :item, description: 'Foo \n Bar\n\n' }

      it 'removed the line breaks' do
        expect(row[:description]).to eq('Foo Bar ')
      end
    end

    it 'has a contact point email from the item maintainer' do
      expect(row[:contactPoint_email]).to eq(item.maintainer)
    end

    it 'has a publisher from the item provider' do
      expect(row[:publisher]).to eq(item.provider)
    end

    it 'uses item provider as creator' do
      expect(row[:creator]).to eq(item.provider)
    end

    it 'has issued from the item date added' do
      expect(row[:issued]).to eq(item.date_added)
    end

    it 'has modified from the item date updated' do
      expect(row[:modified]).to eq(item.date_updated)
    end

    it 'has created from the item date added' do
      expect(row[:created]).to eq(item.date_added)
    end

    it 'has licence from the item license' do
      expect(row[:licence]).to eq(item.license)
    end

    it 'has endpoint URL from item url' do
      expect(row[:endpointURL]).to eq(item.url)
    end

    it 'has endpoint description from item documentation' do
      expect(row[:endpointDescription]).to eq(item.documentation)
    end

    it 'has a uuid as its identifier' do
      expect(row[:identifier]).to match(/\b(uuid:){0,1}\s*([a-f0-9\\-]*){1}\s*/)
    end

    it 'presents the row fields in the same order they are defined in CSV_FIELDS' do
      expect(row.keys).to eq(described_class::CSV_FIELDS.keys)
    end
  end

  describe 'default values' do
    it 'populates defaults except endpointDescription and license' do
      CsvMapper::DEFAULTS.each do |key, value|
        if key == :endpointDescription
          expect(row[key]).to eq(item.documentation)
        elsif key == :licence
          expect(row[key]).to eq(item.license)
        else
          expect(row[key]).to eq(value)
        end
      end
    end

    context 'when item documentation blank' do
      let(:item) { build :item, documentation: '', license: '' }

      it 'populates defaults' do
        CsvMapper::DEFAULTS.each do |key, value|
          expect(row[key]).to eq(value)
        end
      end
    end
  end

  describe 'contact point' do
    let(:maintainer) { 'foo@example.com' }
    let(:item) { create :item, maintainer: }
    let(:name) { row[:contactPoint_contactName] }
    let(:email) { row[:contactPoint_email] }

    it 'populates from an email address' do
      expect(email).to eq(maintainer)
      expect(name).to eq('foo')
    end

    context 'when maintainer is name <email>' do
      let(:maintainer) { 'Ordnance Survey - <osdatahubenquiries@os.uk>' }

      it 'extracts the compontents' do
        expect(email).to eq('osdatahubenquiries@os.uk')
        expect(name).to eq('Ordnance Survey')
      end
    end

    context 'when maintainer is text' do
      let(:maintainer) { Faker::Lorem.sentence }

      it 'uses default email and text for name' do
        expect(email).to eq(described_class::DEFAULT_EMAIL)
        expect(name).to eq(maintainer)
      end
    end

    context 'when maintainer is empty' do
      let(:maintainer) { '' }

      it 'uses default values' do
        expect(email).to eq(described_class::DEFAULT_EMAIL)
        expect(name).to eq(described_class::DEFAULT_CONTACT_NAME)
      end
    end
  end
end
