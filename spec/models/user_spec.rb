require 'rails_helper'

RSpec.describe User do
  
  describe 'validations' do
    it { should validate_presence_of :name }
    
    it { should validate_presence_of :email }

    it { should validate_presence_of :google_id }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
    
    it { should have_many(:followees).through(:followed_users) }

    it { should have_many(:followers).through(:following_users) }
  end

  describe 'instance methods' do
    describe '#friends_by_status' do
      xit 'can determine the ids of which of a users friends are accepted' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)
    
        expect(user.accepted_friend_ids.count).to eq(3)
        expect(user.accepted_friend_ids).to be_a(Array)
        expect(user.accepted_friend_ids).to include(accepted_friends.first.followee_id)
        expect(user.accepted_friend_ids).to_not include(rejected_friends.last.followee_id)
      end

      xit 'returns an empty array if a user has no accepted friends' do
        user = create(:user)

        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.accepted_friend_ids).to eq([])
      end
    end
  end


end

