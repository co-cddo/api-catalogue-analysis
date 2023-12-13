# frozen_string_literal: true

class AddApiStatusToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :api_status, :integer
  end
end
