class Api::V1::FriendsController < ApplicationController
  def index
    if params[:request_status] == "accepted"
      user = User.find_by(google_id: request.headers.env["HTTP_USER"])
      accepted_friend_ids = user.accepted_friend_ids
      render json: UserSerializer.new(User.find(accepted_friend_ids))
    else
      user = User.find_by(google_id: request.headers.env["HTTP_USER"])
      all_friend_ids = user.all_friend_ids
      render json: UserSerializer.new(User.find(all_friend_ids))
    end
  end

  # def index
  #   user = User.find_by(google_id: request.headers.env["HTTP_USER"])
  #   accepted_friend_ids = user.accepted_friend_ids
  #   render json: UserSerializer.new(User.find(accepted_friend_ids))
  # # end

  private

  def session_params

  end
end