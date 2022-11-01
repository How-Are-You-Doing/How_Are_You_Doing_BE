require 'rails_helper'

RSpec.describe Emotion, type: :model do

  describe 'validations' do
    it { should validate_presence_of :word }
    it { should validate_uniqueness_of :word }
   
  end

  describe 'relationships' do
    it { should have_many(:posts) }
  end

end