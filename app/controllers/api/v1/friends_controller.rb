class Api::V1::FriendsController < ApplicationController
  def index
    if params[:request_status]
      user = User.find_by(google_id: request.headers.env["HTTP_USER"])
      friend_ids = user.friends_by_status(params[:request_status])
      render json: UserSerializer.new(User.find(friend_ids))
    else
      user = User.find_by(google_id: request.headers.env["HTTP_USER"])
      all_friend_ids = user.all_friend_ids
      render json: UserSerializer.new(User.find(all_friend_ids))
    end
  end
end