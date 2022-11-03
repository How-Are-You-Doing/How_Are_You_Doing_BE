class Api::V1::FriendsController < ApplicationController
  def index
    # binding.pry
    user = User.find_by(google_id: params[:google_id])
    accepted_friend_ids = user.accepted_friend_ids
    render json: UserSerializer.new(User.find(accepted_friend_ids))
  end
end