class Api::V1::FriendsController < ApplicationController
  def index
    user = User.find_by(google_id: request.headers.env["HTTP_USER"])
    accepted_friend_ids = user.accepted_friend_ids
    render json: UserSerializer.new(User.find(accepted_friend_ids))
  end

  private

  def session_params

  end
end