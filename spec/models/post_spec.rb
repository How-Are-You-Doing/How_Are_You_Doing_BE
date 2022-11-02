require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'validations' do
    it { should validate_presence_of :emotion_id } #add validation for emotion id existing
    it { should validate_numericality_of :emotion_id }
    it { should validate_associated :emotion }
    
    it { should validate_presence_of :description }

    it { should validate_presence_of :post_status }
    it { should validate_numericality_of :post_status }

    it { should validate_presence_of :tone }
    
    it { should define_enum_for(:post_status).with_values([:personal, :shared])}
   
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_one(:emotion) }
  end


end