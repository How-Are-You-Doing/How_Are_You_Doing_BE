class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(
      name: request.headers.env['HTTP_NAME'],
      email: request.headers.env['HTTP_EMAIL'],
      google_id: request.headers.env['HTTP_GOOGLE_ID']
    )
    render json: { message: 'User successfully created' }, status: 201 if user.save
  end
end
