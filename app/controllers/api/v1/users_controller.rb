class Api::V1::UsersController < ApplicationController 

  def create
    user = User.new(name: request.headers.env["HTTP_NAME"], email: request.headers.env["HTTP_EMAIL"], google_id: request.headers.env["HTTP_GOOGLE_ID"] )
    if user.save
      render status: 201
    end
  end
end