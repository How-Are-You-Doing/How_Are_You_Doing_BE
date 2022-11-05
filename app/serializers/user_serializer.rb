class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :google_id

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


  def self.user_google_id(user)
    {
      "data": {
        "id": user.id.to_s,
        "type": user.class.name.downcase,
        attributes: {
            name: user.name,
            email: user.email,
            google_id: user.google_id
          }
      }
    }
  end
end