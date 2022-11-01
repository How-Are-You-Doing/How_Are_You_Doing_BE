class User < ApplicationRecord
  has_many :posts
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friend'
  has_many :followees, through: :followed_users

  validates_presence_of :name, :email, :phone_number

end