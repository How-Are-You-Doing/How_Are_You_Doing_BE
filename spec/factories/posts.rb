require 'faker'

FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentence }
    post_status { rand(0..1) }
    tone { Faker::Emotion.noun }
    user
    emotion
  end
end 