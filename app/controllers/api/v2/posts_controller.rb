class Api::V2::PostsController < ApplicationController
  def show
    user = User.find_by(google_id: current_user_params[:user])
    post = user.most_recent_post
    if post.nil?
      render json: { data: {} }
    else
      render json: PostSerializer.new(post)
    end
  end

  def create
    require "pry"; binding.pry
    found_user = User.find_by(google_id: current_user_params[:user])
    found_emotion = Emotion.find_by(term: emotion_params[:emotion])
    found_tone = ToneFacade.analyze_tone(post_params[:description])
    post = Post.new(user: found_user, tone: found_tone, emotion: found_emotion)

    if post.update(post_params)
      render json: PostSerializer.new(post), status: :created
    else
      render json:{data: {}}, status: :bad_request
    end
  end

  private

  def current_user_params
    params.permit(:user)
  end

  def emotion_params
    params.permit(:emotion)
  end

  def post_params
    params.permit(:description, :post_status)
  end
end
