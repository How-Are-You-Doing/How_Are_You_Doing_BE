class Api::V1::EmotionsController < ApplicationController 

  def index
    Emotion.get_definitions
    render json: EmotionSerializer.new(Emotion.all)
  end

end
