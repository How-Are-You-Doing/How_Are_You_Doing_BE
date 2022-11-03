require 'rails_helper'

RSpec.describe User do
  
  describe 'validations' do
    it { should validate_presence_of :name }
    
    it { should validate_presence_of :email }

    it { should validate_presence_of :phone_number }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
    
    it { should have_many(:followees).through(:followed_users) }

    it { should have_many(:followers).through(:following_users) }
  end

  describe 'instance methods' do
    describe '#accepted_friends' do
      it 'can determine which of a users friends are accepted' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        binding.pry
        expect(user.accepted_friends.count).to eq(3)
      end
    end
  end


end

