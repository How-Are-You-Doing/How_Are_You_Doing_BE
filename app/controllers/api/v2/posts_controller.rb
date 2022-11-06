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

  def update
    # require "pry"; binding.pry
    post = Post.find(params[:id])
    new_emotion = Emotion.find_by(term: emotion_params[:emotion]).id if emotion_params[:emotion].present?
    new_tone = ToneFacade.analyze_tone(post_params[:description]) if find_tone_requirments?(post)

    new_post_params = post_params.merge(found_new_params(new_emotion, new_tone))
    # require "pry"; binding.pry
    if post.update(new_post_params)
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

  def find_tone_requirments?(post)
    post.description != post_params[:description] && post_params[:description].present?
  end

  def found_new_params(new_emotion, new_tone)
    emotion_hash = Hash.new
    emotion_hash[:emotion_id] = new_emotion if new_emotion.present?
    emotion_hash[:tone] = new_tone if new_tone.present?
    emotion_hash
  end

end
