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
    describe '#followees_ids_by_status' do
      it 'can determine the ids of which of a users friends are accepted' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_ids_by_status('accepted').count).to eq(3)
        expect(user.followees_ids_by_status('accepted')).to be_an(Array)
        expect(user.followees_ids_by_status('accepted')).to include(accepted_friends.first.followee_id)
        expect(user.followees_ids_by_status('accepted')).to_not include(rejected_friends.last.followee_id)
        expect(user.followees_ids_by_status('accepted')).to_not include(pending_friends.last.followee_id)
      end

      it 'can determine the ids of which of a users friends are pending' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_ids_by_status('pending').count).to eq(3)
        expect(user.followees_ids_by_status('pending')).to be_an(Array)
        expect(user.followees_ids_by_status('pending')).to include(pending_friends.first.followee_id)
        expect(user.followees_ids_by_status('pending')).to_not include(rejected_friends.last.followee_id)
        expect(user.followees_ids_by_status('pending')).to_not include(accepted_friends.last.followee_id)
      end

      it 'can determine the ids of which of a users friends are rejected' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_ids_by_status('rejected').count).to eq(3)
        expect(user.followees_ids_by_status('rejected')).to be_an(Array)
        expect(user.followees_ids_by_status('rejected')).to include(rejected_friends.first.followee_id)
        expect(user.followees_ids_by_status('rejected')).to_not include(accepted_friends.last.followee_id)
        expect(user.followees_ids_by_status('rejected')).to_not include(pending_friends.last.followee_id)
      end

      it 'returns an empty array if a user has no friends' do
        user = create(:user)

        randos = create_list(:friend, 5)

        expect(user.followees_ids_by_status('rejected')).to eq([])
        expect(user.followees_ids_by_status('accepted')).to eq([])
        expect(user.followees_ids_by_status('pending')).to eq([])
      end
    end

    describe '#followees_by_status' do
      it 'can determine the followees a users has been are accepted to follow' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_by_status('accepted').count).to eq(3)
        expect(user.followees_by_status('accepted')).to include(accepted_friends.first)
        expect(user.followees_by_status('accepted')).to_not include(rejected_friends.last)
        expect(user.followees_by_status('accepted')).to_not include(pending_friends.last)
      end

      it 'can determine the followees who have a pending  follow request from a user' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_by_status('pending').count).to eq(3)
        expect(user.followees_by_status('pending')).to include(pending_friends.first)
        expect(user.followees_by_status('pending')).to_not include(rejected_friends.last)
        expect(user.followees_by_status('pending')).to_not include(accepted_friends.last)
      end

      it 'can determine the followees a who rejected a users request to follow' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followees_by_status('rejected').count).to eq(3)
        expect(user.followees_by_status('rejected')).to include(rejected_friends.first)
        expect(user.followees_by_status('rejected')).to_not include(accepted_friends.last)
        expect(user.followees_by_status('rejected')).to_not include(pending_friends.last)
      end

      it 'returns an empty array if a user has not requested to follow any other users' do
        user = create(:user)

        randos = create_list(:friend, 5)

        expect(user.followees_by_status('rejected')).to eq([])
        expect(user.followees_by_status('accepted')).to eq([])
        expect(user.followees_by_status('pending')).to eq([])
      end
    end

    describe "#all_followees_ids" do
      it 'returns ids of all users that have a friend relationship with the user' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.all_followees_ids.count).to eq(9)
        expect(user.all_followees_ids).to be_a(Array)
        expect(user.all_followees_ids).to include(rejected_friends.first.followee_id)
        expect(user.all_followees_ids).to include(accepted_friends.first.followee_id)
        expect(user.all_followees_ids).to include(pending_friends.last.followee_id)
        expect(user.all_followees_ids).to_not include(randos.last.followee_id)
      end

      it 'returns an empty array if a user has no friend relationships' do
        user = create(:user)
        randos = create_list(:friend, 5)

        expect(user.all_followees_ids).to eq([])
      end
    end

    describe "#most_recent_post" do
      it 'returns a users most recent post' do
        user = create(:user)
        oldest_post = create(:post, user: user, created_at: 100.day.ago)
        middle_post = create(:post, user: user, created_at: 50.day.ago)
        newest_post = create(:post, user: user, created_at: 1.day.ago)
        create_list(:post, 5)

        expect(user.most_recent_post).to eq(newest_post)
      end
    end

    describe "#public_posts" do
      it 'returns only public/shared posts for a user' do
        user = create(:user)
        posts = create_list(:post, 2, user: user, post_status: :personal)
        posts = create_list(:post, 3, user: user, post_status: :shared)
        other_users_posts = create_list(:post, 5)

        expect(user.public_posts.count).to eq(3)
        user.public_posts.each{|post| expect(post.post_status).to eq('shared')}
      end

      it 'returns no posts if all posts for a user are private/personal' do
        user = create(:user)
        posts = create_list(:post, 4, user: user, post_status: :personal)
        other_users_posts = create_list(:post, 5)

        expect(user.public_posts.count).to eq(0)
      end
    end

    describe '#followers_by_status' do
      it 'can determine the ids of the users the current user has accepted the follow requests' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followers_by_status('accepted').count).to eq(3)
        expect(user.followers_by_status('accepted')).to include(accepted_followers.first)
        expect(user.followers_by_status('accepted')).to_not include(rejected_followers.last)
        expect(user.followers_by_status('accepted')).to_not include(pending_followers.last)
      end

      it 'can determine the ids of the users the current user has pending follow request' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        expect(user.followers_by_status('pending').count).to eq(3)
        expect(user.followers_by_status('pending')).to include(pending_followers.first)
        expect(user.followers_by_status('pending')).to_not include(rejected_followers.last)
        expect(user.followers_by_status('pending')).to_not include(accepted_followers.last)
      end

      it 'can determine the ids of the users the current user has rejected the follow request' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)
        
        expect(user.followers_by_status('rejected').count).to eq(3)
        expect(user.followers_by_status('rejected')).to include(rejected_followers.first)
        expect(user.followers_by_status('rejected')).to_not include(accepted_followers.last)
        expect(user.followers_by_status('rejected')).to_not include(pending_followers.last)
      end

      it 'returns an empty array if a user has no follower requests' do
        user = create(:user)

        randos = create_list(:friend, 5)

        expect(user.followers_by_status('rejected')).to eq([])
        expect(user.followers_by_status('accepted')).to eq([])
        expect(user.followers_by_status('pending')).to eq([])
      end
    end
  end
end
