class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :google_id

  def self.friends(users_friends, type)
    {
      data:
      users_friends.map do |friend|
        friend_id = friend.followee_id if type == "followee"
        friend_id = friend.follower_id if type == "follower"
        user = User.find(friend_id)
        {
          id: user.id,
          friendship_id: friend.id,
          type: "friend_#{type}",
          attributes: {
            name: user.name,
            email: user.email,
            google_id: user.google_id,
            request_status: friend.request_status
          }
        }
      end
    }
  end
end
