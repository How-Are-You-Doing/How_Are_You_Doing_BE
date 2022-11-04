class Api::V1::Users::PostsController < ApplicationController 
  def index
    require "pry"; binding.pry
    user = 
    render json: PostSerializer.new(Post.find_by(user))
  end
end