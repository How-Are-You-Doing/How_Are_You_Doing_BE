class Api::V1::Users::PostsController < ApplicationController 
  def index
    if user_header
      user = User.find_by(google_id: user_header)
      render json: PostSerializer.new(Post.where(user_id: user.id))
    else
      render json:{data: {}}, status: :bad_request
    end
  end

  def most_recent
    user = User.find_by(google_id: user_header)
    post = user.most_recent_post
    if post.nil?
      render json: {:data=>[]}
    else
      render json: PostSerializer.new(post)
    end
  end

  private

  def user_header
    request.headers.env["HTTP_USER"]
  end
end