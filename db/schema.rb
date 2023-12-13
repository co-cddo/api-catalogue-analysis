# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_231_017_151_424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'items', force: :cascade do |t|
    t.string 'date_added'
    t.string 'date_updated'
    t.string 'url'
    t.string 'name'
    t.text 'description'
    t.string 'documentation'
    t.string 'license'
    t.string 'maintainer'
    t.string 'area_served'
    t.string 'start_date'
    t.string 'end_date'
    t.string 'provider'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'number_required'
    t.json 'metadata'
    t.integer 'api_status'
  end
end
