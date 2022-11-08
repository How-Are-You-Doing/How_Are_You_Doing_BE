class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :google_id

  def self.followees(followee_friends)
    {
      data:
      followee_friends.map do |friend|
        user = User.find(friend.followee_id)
        {
          id: user.id,
          friendship_id: friend.id,
          type: "friend_followee",
          attributes: {
            name: user.name,
            email: user.email,
            google_id: user.google_id
          }
        }
      end
    }
  end

  def self.followers(follower_friends)
    {
      data: 
      follower_friends.map do |friend|
        user = User.find(friend.follower_id)
        {
          id: user.id,
          friendship_id: friend.id,
          type: "friend_follower",
          attributes: {
            name: user.name,
            email: user.email,
            google_id: user.google_id
          }
        }
      end
    }
  end
end
