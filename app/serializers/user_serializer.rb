class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email

  def self.user_email(user)
    {
      "data": {
        "id": user.id.to_s,
        "type": user.class.name.downcase,
        attributes: {
            name: user.name
          }
      }
    }
  end
end