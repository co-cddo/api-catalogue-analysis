# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    date_added { 3.days.ago.to_date.to_formatted_s(:db) }
    date_updated { 2.days.ago.to_date.to_formatted_s(:db) }
    url { Faker::Internet.url(host: 'example.com') }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    documentation { Faker::Internet.url(host: 'example.com') }
    license { Faker::Subscription.plan }
    maintainer { Faker::Internet.email }
    area_served { Faker::Address.state }
    start_date { 1.days.ago.to_date.to_formatted_s(:db) }
    end_date { 2.days.from_now.to_date.to_formatted_s(:db) }
    provider { Faker::Company.name }
  end
end
