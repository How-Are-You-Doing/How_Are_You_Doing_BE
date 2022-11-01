require 'rails_helper'

RSpec.describe User do
  
  describe 'validations' do
    it { should validate_presence_of :name }
    
    it { should validate_presence_of :email }

    it { should validate_presence_of :phone_number }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
    it { should have_many(:friends) }
  end

end

