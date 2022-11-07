class Api::V2::Users::PostsController < ApplicationController
  def index
    user = User.find_by(google_id: current_user_params[:user])
    if !user.nil?
      render json: PostSerializer.new(Post.where(user_id: user.id))
    else
      render json: { data: {} }, status: :bad_request
    end
  end


  private

  def current_user_params
    params.permit(:user)
  end
end
