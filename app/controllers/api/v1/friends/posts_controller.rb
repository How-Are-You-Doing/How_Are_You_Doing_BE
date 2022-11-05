class Api::V1::Friends::PostsController < ApplicationController
  def index
    user = User.find_by(google_id: params[:friend_id])
    posts = user.public_posts
    render json: PostSerializer.new(posts)
  end
end