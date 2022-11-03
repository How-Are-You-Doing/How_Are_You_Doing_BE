class Api::V1::FriendsController < ApplicationController
  def index
    render json: FriendSerializer.new(Friend.all)
  end
end