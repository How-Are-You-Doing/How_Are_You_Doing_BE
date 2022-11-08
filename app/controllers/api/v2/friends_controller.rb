class Api::V2::FriendsController < ApplicationController
  def index
    user = User.find_by(google_id: current_user_params[:user])

    if friend_params[:request_status].present?
      followee_friends = user.followees_by_status(friend_params[:request_status])
      render json: UserSerializer.followees(followee_friends)
    else
      all_followees = user.followed_users
      render json: UserSerializer.followees(all_followees)
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
