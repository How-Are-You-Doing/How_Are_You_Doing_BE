require 'faker'

oauth_hash = Faker::Omniauth.google

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { oauth_hash[:uid] }
  end
end 