class Post < ApplicationRecord
  belongs_to :user
  has_one :emotion

  validates_presence_ of :emotion_id, :description, :post_status, :tone
  validates_numericality_ of :emotion_id, :post_status

end