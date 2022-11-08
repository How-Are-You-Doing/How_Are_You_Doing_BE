class User < ApplicationRecord
  has_many :posts
  #sets up who the user is following
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friend' 
  has_many :followees, through: :followed_users
  #sets up who is following the user
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friend'
  has_many :followers, through: :following_users

  validates_presence_of :name, :email, :google_id

  def all_followees_ids
    followed_users.pluck(:followee_id)
  end

  def followees_ids_by_status(status)
    followed_users.where(request_status: status).pluck(:followee_id)
  end

  def followees_by_status(status)
    followed_users.where(request_status: status)
  end

  def most_recent_post
    posts.order(created_at: :desc).first
  end

  def public_posts
    posts.where(post_status: 'shared')
  end

  def followers_by_status(status)
    following_users.where(request_status: status)
  end
end