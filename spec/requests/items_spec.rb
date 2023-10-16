require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:item) { create :item }
    it "returns http success" do
      get item_path(item)
      expect(response).to have_http_status(:success)
    end
  end

end
