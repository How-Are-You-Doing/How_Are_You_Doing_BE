require 'faker'

FactoryBot.define do
  factory :friend do
    association :follower, factory: :user
    association :followee, factory: :user
    request_status { 0 }
  end
end
