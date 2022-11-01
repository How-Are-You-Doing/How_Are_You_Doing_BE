class Post < ApplicationRecord
  enum post_status: { private: 0, public: 1 }
  belongs_to :user
  has_one :emotion

  validates_presence_of :emotion_id, :description, :post_status, :tone
  validates_numericality_of :emotion_id, :post_status
  validates_associated :emotion

end