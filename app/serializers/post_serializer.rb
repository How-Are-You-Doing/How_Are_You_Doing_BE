class PostSerializer
  include JSONAPI::Serializer
  attributes :emotion do |post|
    "#{Emotion.find(post.emotion_id).term}"
  end
  attributes :post_status, :description, :tone, :created_at
end