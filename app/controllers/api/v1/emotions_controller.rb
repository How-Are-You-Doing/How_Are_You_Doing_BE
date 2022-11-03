class Api::V1::EmotionsController < ApplicationController 

  def index
    emotions = Emotion.get_definitions
    render jason: EmotionSerializer.new(emotions)
  end

end
