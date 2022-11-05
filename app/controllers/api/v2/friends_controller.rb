class Api::V2::FriendsController < ApplicationController

  def index
    user = User.find_by(google_id: current_user_params[:user])

    if friend_params[:request_status].present?
      friend_ids = user.friends_by_status(friend_params[:request_status])
      render json: UserSerializer.new(User.find(friend_ids))
    else
      all_friend_ids = user.all_friend_ids
      render json: UserSerializer.new(User.find(all_friend_ids))
    end
  end

  def create
    requester = User.find_by(google_id: current_user_params[:user])
    requestee = User.find_by(email: friend_params[:email])
    friend = Friend.new(follower: requester, followee: requestee, request_status: 0)
    render json: { message: 'Friend successfully created' }, status: 201 if friend.save
  end

  def update
    friendship = Friend.find(params[:id])
    friendship.update(request_status: friend_params[:request_status].to_i)
    render json: { message: "This request was #{friendship.request_status}" }, status: 201 if friendship.save
  end

  private

  def current_user_params
    params.permit(:user)
  end

  def friend_params
    params.permit(:request_status, :email)
  end
end
