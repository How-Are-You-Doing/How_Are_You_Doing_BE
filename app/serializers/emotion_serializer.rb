class EmotionSerializer 
  include JSONAPI::Serializer
  attributes :term, :definition
end