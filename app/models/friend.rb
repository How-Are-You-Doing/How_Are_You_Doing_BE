class Friend < ApplicationRecord
  enum request_status: { pending: 0, accepted: 1, rejected: 2 }

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates_presence_of :follower_id, :followee_id, :request_status
  validates_numericality_of :follower_id, :followee_id
end