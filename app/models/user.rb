class User < ApplicationRecord
  has_many :posts
  #sets up who the user is following
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friend' 
  has_many :followees, through: :followed_users
  #sets up who is following the user
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friend'
  has_many :followers, through: :following_users

  validates_presence_of :name, :email, :phone_number

  def accepted_friend_ids
    followed_users.where(request_status: "accepted").pluck(:followee_id)
  end
end