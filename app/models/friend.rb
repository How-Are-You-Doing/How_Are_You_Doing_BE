class Friend < ApplicationRecord
  # include Comparable
  
  enum request_status: { pending: 0, accepted: 1, rejected: 2 }

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  # validates :followee_id, comparison: { other_than: :follower_id }
  validates_presence_of :follower_id, :followee_id, :request_status
  validates_numericality_of :follower_id, :followee_id
  validate :check_for_requesting_self
  validate :check_for_existing_request






  private 

  def check_for_requesting_self
    errors.add(:followee_id, "Sorry, you can't follow yourself.") if follower_id == followee_id
  end

  def check_for_existing_request
    follower = User.find_by(id: follower_id)
    followee = User.find_by(id: followee_id)
    follower_followed_ids = follower.all_followees_ids
    if follower_followed_ids.include?(followee.id)
      errors.add(:request_status, ": you have already requested this user.")
    end
  end
end
