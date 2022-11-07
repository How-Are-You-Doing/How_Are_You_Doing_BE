require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { rand(100_000.1000000000) }
  end
end
