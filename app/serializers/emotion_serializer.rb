class EmotionSerializer
  include JSONAPI::Serializer
  attributes :emotion, &:term
  attributes :definition
end
