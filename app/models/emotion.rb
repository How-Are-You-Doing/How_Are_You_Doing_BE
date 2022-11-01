class Emotion < ApplicationRecord
  has_many :posts
  validates_presence_of :word
  validates_uniqueness_of :word

end