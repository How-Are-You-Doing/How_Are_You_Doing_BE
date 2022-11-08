class Api::V2::FriendsController < ApplicationController
  def index
    user = User.find_by(google_id: current_user_params[:user])

    if friend_params[:request_status].present?
      followee_friends = user.followees_by_status(friend_params[:request_status])
      render json: UserSerializer.friends(followee_friends, "followee")
    else
      all_followees = user.followed_users
      render json: UserSerializer.friends(all_followees, "followee")
    end
  end

  def create
    follower = User.find_by(google_id: current_user_params[:user])
    followee = User.find_by(email: friend_params[:email])
    friend = Friend.create(follower: follower, followee: followee, request_status: 0)
    render json: UserSerializer.friend(friend, "followee"), status: 201 if friend.save
  end

  def update
    friendship = Friend.find(params[:id])
    friendship.update(request_status: friend_params[:request_status])
    render json: UserSerializer.friend(friendship, "followee"), status: 201 if friendship.save
  end

  private

  def current_user_params
    params.permit(:user)
  end

  def friend_params
    params.permit(:request_status, :email)
  end
end
