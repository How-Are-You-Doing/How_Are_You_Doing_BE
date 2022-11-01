class User < ApplicationRecord
  has_many :posts
  has_many :friends

  validates_presence_of :name, :email, :phone_number

end