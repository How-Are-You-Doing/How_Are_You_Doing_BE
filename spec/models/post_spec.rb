require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of :emotion_id } 
    it { should validate_numericality_of :emotion_id }

    it { should validate_presence_of :description }

    it { should validate_presence_of :post_status }

    it { should validate_presence_of :tone }

    it { should define_enum_for(:post_status).with_values([:personal, :shared])}
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:emotion) }
  end
end
