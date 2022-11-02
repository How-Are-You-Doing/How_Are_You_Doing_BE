class Post < ApplicationRecord
  enum post_status: { personal: 0, shared: 1 }
  belongs_to :user
  belongs_to :emotion

  validates_presence_of :emotion_id, :description, :post_status, :tone
  validates_numericality_of :emotion_id, :post_status
  validates_associated :emotion

end