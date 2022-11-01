require 'rails_helper'

RSpec.describe Friend do

  describe 'validations' do
    it { should validate_presence_of :follower_id }
    it { should validate_numericality_of :follower_id }
      
    it { should validate_presence_of :followee_id }
    it { should validate_numericality_of :followee_id }

    it { should validate_presence_of :request_status }
    it { should validate_numericality_of :request_status }
  end

  describe 'relationships' do
    it 
    
  end

end