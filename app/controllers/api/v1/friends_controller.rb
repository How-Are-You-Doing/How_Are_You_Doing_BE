class Api::V1::FriendsController < ApplicationController
  def index
    # binding.pry
    # user = #will need to find a user by session params here
    # accepted_friend_ids = user.accepted_friend_ids
    render json: UserSerializer.new(User.find(accepted_friend_ids))
  end
end