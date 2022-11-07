class FriendSerializer
  include JSONAPI::Serializer
  attributes :follower_id, :followee_id, :request_status
end
