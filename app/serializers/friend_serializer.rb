class FriendSerializer
  include JSONAPI::Serializer
  attributes :follower_id, :followee_id, :request_status
  attributes :follower do  |friend|
    UserSerializer.new(User.find(friend.follower_id))
  end
  attributes :followee do  |friend|
    UserSerializer.new(User.find(friend.followee_id))
  end
end
