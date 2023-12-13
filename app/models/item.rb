# frozen_string_literal: true

class Item < ApplicationRecord
  def api_response
    @api_response ||= Faraday.get(url)
  rescue Faraday::SSLError, URI::InvalidURIError => e
    @api_response = OpenStruct.new status: 500, body: e.message
  end
end
