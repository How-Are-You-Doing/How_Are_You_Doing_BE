require 'rails_helper'

RSpec.describe Emotion, type: :model do

  describe 'validations' do
    it { should validate_presence_of :term }
    it { should validate_uniqueness_of :term }
    
    it { should validate_presence_of :definition }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
  end
end