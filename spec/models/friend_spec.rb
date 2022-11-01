require 'rails_helper'

RSpec.describe Friend do

  describe 'validations' do
    it { should validate_presence_of :follower }
    it { should validate_numericality_of :follower }
      
    it { should validate_presence_of :followee }
    it { should validate_numericality_of :followee }

    it { should validate_presence_of :request_status }
    it { should validate_numericality_of :request_status }
  end

describe 'relationships' do
  it { should have_many(:posts) }
  it { should have_many(:friends) }
end

end