class Api::V1::FriendsController < ApplicationController
  def index
    user = User.find_by(google_id: request.headers.env['HTTP_USER'])
    if params[:request_status]
      friend_ids = user.friends_by_status(params[:request_status])
      render json: UserSerializer.new(User.find(friend_ids))
    else
      all_friend_ids = user.all_friend_ids
      render json: UserSerializer.new(User.find(all_friend_ids))
    end
  end

  def create
    requester = User.find_by(google_id: request.headers.env['HTTP_USER'])
    requestee = User.find_by(email: params[:email])
    friend = Friend.new(follower: requester, followee: requestee, request_status: 0)
    render json: { message: 'Friend successfully created' }, status: 201 if friend.save
  end

  def update
    friendship = Friend.find(params[:id])
    friendship.update(request_status: request.headers.env['HTTP_REQUEST_STATUS'].to_i)
    render json: { message: "This request was #{friendship.request_status}" }, status: 201 if friendship.save
  end
end
