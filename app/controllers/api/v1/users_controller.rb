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

  def index
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      render json: UserSerializer.user_email(user)
    else
      render json: {:data=>[]}
    end
  end
end
