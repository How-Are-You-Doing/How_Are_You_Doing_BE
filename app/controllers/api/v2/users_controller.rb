class Api::V2::UsersController < ApplicationController
  def create
    user = User.new(name: user_params[:name], email: user_params[:email], google_id: user_params[:google_id])

    render json: { message: 'User successfully created' }, status: 201 if user.save
  end

  def search
    if params[:email]
      render_user_by_email
    elsif params[:search]
      render_user_by_google_id
    end
  end


  private

  def user_params
    params.permit(:name, :email, :google_id)
  end

  def render_user_by_email
    user = User.find_by(email: user_params[:email])
      if user.present?
        render json: UserSerializer.new(user)
      else
        render json: {data: {}}
      end
  end

  def render_user_by_google_id
    user = User.find_by(google_id: params[:search])
    if user.present?
      render json: UserSerializer.new(user)
    else
      render json: {data: {}}
    end
  end
end
