require 'faker'

FactoryBot.define do
  factory :emotion do
    term { Faker::Emotion.unique.adjective }
    definition { Faker::Lorem.sentence }
  end
end 