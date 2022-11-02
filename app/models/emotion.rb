class Emotion < ApplicationRecord
  has_many :posts
  validates_presence_of :term, :definition
  validates_uniqueness_of :term

end