class Api::V2::Users::FollowersController < ApplicationController
  def index
    user = User.find_by(google_id: current_user_params[:user])

    if status_params.present?
      render_followers_by_status(user)
    else
      render_all_followers(user)
    end
  end

  private

  def current_user_params
    params.permit(:user)
  end

  def status_params 
    params.permit(:request_status)
  end

  def render_followers_by_status(user)
    if user.present?
      follower_ids = user.followers_by_status(status_params[:request_status])
      render json: UserSerializer.new(User.find(follower_ids))
    else
      render json: { data: [] }, status: :bad_request
    end
  end

  def render_all_followers(user)
    if user.present?
      render json: UserSerializer.new(user.followers)
    else
      render json: { data: [] }, status: :bad_request
    end
  end
end