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
      it 'can determine the ids of which of a users friends are accepted' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)
    
        expect(user.friends_by_status("accepted").count).to eq(3)
        expect(user.friends_by_status("accepted")).to be_a(Array)
        expect(user.friends_by_status("accepted")).to include(accepted_friends.first.followee_id)
        expect(user.friends_by_status("accepted")).to_not include(rejected_friends.last.followee_id)
      end

      it 'can determine the ids of which of a users friends are pending' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)
    
        expect(user.friends_by_status("pending").count).to eq(3)
        expect(user.friends_by_status("pending")).to be_a(Array)
        expect(user.friends_by_status("pending")).to include(pending_friends.first.followee_id)
        expect(user.friends_by_status("pending")).to_not include(rejected_friends.last.followee_id)
      end

      it 'can determine the ids of which of a users friends are rejected' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)
    
        expect(user.friends_by_status("rejected").count).to eq(3)
        expect(user.friends_by_status("rejected")).to be_a(Array)
        expect(user.friends_by_status("rejected")).to include(rejected_friends.first.followee_id)
        expect(user.friends_by_status("rejected")).to_not include(accepted_friends.last.followee_id)
      end

      it 'returns an empty array if a user has no friends' do
        user = create(:user)

        randos = create_list(:friend, 5)

        expect(user.friends_by_status("rejected")).to eq([])
        expect(user.friends_by_status("accepted")).to eq([])
        expect(user.friends_by_status("pending")).to eq([])
      end
    end

    describe "#all_friend_ids" do
      it 'returns ids of all users that have a friend relationship with the user' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)
    
        expect(user.all_friend_ids.count).to eq(9)
        expect(user.all_friend_ids).to be_a(Array)
        expect(user.all_friend_ids).to include(rejected_friends.first.followee_id)
        expect(user.all_friend_ids).to include(accepted_friends.first.followee_id)
        expect(user.all_friend_ids).to include(pending_friends.last.followee_id) 
        expect(user.all_friend_ids).to_not include(randos.last.followee_id) 
      end

      it 'returns an empty array if a user has no friend relationships' do
        user = create(:user)
        randos = create_list(:friend, 5)

        expect(user.all_friend_ids).to eq([])
      end
    end
  end


end

