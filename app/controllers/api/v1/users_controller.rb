class Api::V1::UsersController < ApplicationController 

  def create
    user = User.new(
      name: request.headers.env["HTTP_NAME"],
      email: request.headers.env["HTTP_EMAIL"],
      google_id: request.headers.env["HTTP_GOOGLE_ID"],
    )
    if user.save
      render json: { message: 'User successfully created' }, status: 201
    end
  end

  def search
    if params[:email]
      render_user_by_email
    elsif params[:search]
      render_user_by_google_id
    end
  end

  private

  def render_user_by_email
      if User.exists?(email: params[:email])
        user = User.find_by(email: params[:email])
        render json: UserSerializer.user_email(user)
      else
        render json: {:data=>[]}
      end
  end

  def render_user_by_google_id
    if User.exists?(google_id: params[:search])
      user = User.find_by(google_id: params[:search])
      render json: UserSerializer.user_google_id(user)
    else
      render json: {:data=>[]}
    end
  end


end
