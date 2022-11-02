require 'faker'

FactoryBot.define do
  factory :emotion do
    term { Faker::Emotion.adjective }
    definition { Faker::Lorem.sentence }
  end
end 