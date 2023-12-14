# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let(:organisation) { 'academy-for-social-justice' } # first name from source data

  describe 'names' do
    subject(:names) { described_class.names }

    it 'is an array of strings' do
      expect(names).to be_a(Array)
      expect(names.map(&:class).uniq).to eq([String])
    end

    it 'populates from uk-gov-orgs.yaml' do
      expect(names.first).to eq(organisation)
    end
  end
end
