# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :date_added
      t.string :date_updated
      t.string :url
      t.string :name
      t.text :description
      t.string :documentation
      t.string :license
      t.string :maintainer
      t.string :area_served
      t.string :start_date
      t.string :end_date
      t.string :provider

      t.timestamps
    end
  end
end
