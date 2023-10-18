require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { create :item }
  let(:status) { 200 }

  before do
    stub_request(:get, item.url).to_return(status: status)
  end
  describe '#api_response' do
    it 'returns a success status' do
      expect(item.api_response.status).to eq(200)
    end
  end

  context 'when server down' do
    let(:status) { 500 }
    it 'returns the error status' do
      expect(item.api_response.status).to eq(500)
    end
  end
end
