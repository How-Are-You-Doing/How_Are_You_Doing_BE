require 'rails_helper'

describe 'Friends API' do
  describe 'Friends Index' do
    describe 'happy path' do
      it 'sends a list of all of users who have a relationship with the logged in user' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { 'user' => "#{user.google_id}" }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)

        friends = friends_data[:data]
        expect(friends.count).to eq(9)

        friends.each do |friend|
          expect(friend[:id].to_i).to be_a(Integer)
          expect(friend[:friend_id].to_i).to be_a(Integer)
          expect(friend[:type]).to eq('friend_followee')
          expect(friend[:attributes].count).to eq(4)
          expect(friend[:attributes][:name]).to be_a(String)
          expect(friend[:attributes][:email]).to be_a(String)
          expect(friend[:attributes][:google_id]).to be_a(String)
          expect(friend[:attributes][:request_status]).to be_a(String)
        end
      end

      it 'sends a list of all of a users friends that have accepted their request' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'accepted' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)

        friends = friends_data[:data]
        expect(friends.count).to eq(3)
        expect(accepted_friends.first.followee_id).to eq(friends.first[:id].to_i)
        expect(accepted_friends.last.followee_id).to eq(friends.last[:id].to_i)

        friends.each do |friend|
          expect(friend[:id].to_i).to be_a(Integer)
          expect(friend[:friend_id].to_i).to be_a(Integer)
          expect(friend[:type]).to eq('friend_followee')
          expect(friend[:attributes].count).to eq(4)
          expect(friend[:attributes][:name]).to be_a(String)
          expect(friend[:attributes][:email]).to be_a(String)
          expect(friend[:attributes][:google_id]).to be_a(String)
          expect(friend[:attributes][:request_status]).to be_a(String)
        end
      end

      it 'sends a list of all of a users friends that have a pending request' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'pending' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)

        friends = friends_data[:data]
        expect(friends.count).to eq(3)
        expect(pending_friends.first.followee_id).to eq(friends.first[:id].to_i)
        expect(pending_friends.last.followee_id).to eq(friends.last[:id].to_i)

        friends.each do |friend|
          expect(friend[:id].to_i).to be_a(Integer)
          expect(friend[:friend_id].to_i).to be_a(Integer)
          expect(friend[:type]).to eq('friend_followee')
          expect(friend[:attributes].count).to eq(4)
          expect(friend[:attributes][:name]).to be_a(String)
          expect(friend[:attributes][:email]).to be_a(String)
          expect(friend[:attributes][:google_id]).to be_a(String)
          expect(friend[:attributes][:request_status]).to be_a(String)
        end
      end

      it 'sends a list of all of a users friends that have rejected their request' do
        user = create(:user)

        accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
        rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
        pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'rejected' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)

        friends = friends_data[:data]

        expect(friends.count).to eq(3)
        expect(rejected_friends.first.followee_id).to eq(friends.first[:id].to_i)
        expect(rejected_friends.last.followee_id).to eq(friends.last[:id].to_i)

        friends.each do |friend|
          expect(friend[:id].to_i).to be_a(Integer)
          expect(friend[:friend_id].to_i).to be_a(Integer)
          expect(friend[:type]).to eq('friend_followee')
          expect(friend[:attributes].count).to eq(4)
          expect(friend[:attributes][:name]).to be_a(String)
          expect(friend[:attributes][:email]).to be_a(String)
          expect(friend[:attributes][:google_id]).to be_a(String)
          expect(friend[:attributes][:request_status]).to be_a(String)
        end
      end
    end

    describe 'sad path' do
      it 'sends an empty data hash back if there are no matches for all friends' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}" }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)
        expect(friends_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for accepted friends' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'accepted' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)
        expect(friends_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for pending friends' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'pending' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)
        expect(friends_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for rejected friends' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'rejected' }

        get '/api/v2/friends', params: params

        expect(response).to be_successful

        friends_data = JSON.parse(response.body, symbolize_names: true)
        expect(friends_data).to eq({ data: [] })
      end
    end
  end

  describe 'creating a friend relationship' do
    describe 'happy path' do
      it 'Can create a new friend relationship with a default status of pending' do
        requester = create(:user)
        requestee = create(:user)
        create_list(:user, 3)

        params = { user: "#{requester.google_id}",
                   email: "#{requestee.email}" }

        post '/api/v2/friends', params: params

        created_friend = Friend.last

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_friend.follower_id).to eq(requester.id)
        expect(created_friend.followee_id).to eq(requestee.id)
        expect(created_friend.request_status).to eq('pending')
      end

      it 'sends back the information about the new friendship to the front end' do
        follower = create(:user)
        followee = create(:user)
        create_list(:user, 3)

        params = { user: "#{follower.google_id}",
                   email: "#{followee.email}" }

        post '/api/v2/friends', params: params

        expect(response).to be_successful
        friend_data = JSON.parse(response.body, symbolize_names: true)
        friend = friend_data[:data]

        expect(friend[:id]).to eq(followee.id)
        expect(friend[:type]).to eq("friend_followee")
        expect(friend[:attributes].count).to eq(4)
        expect(friend[:attributes][:name]).to be_a(String)
        expect(friend[:attributes][:email]).to be_a(String)
        expect(friend[:attributes][:google_id]).to be_a(String)
        expect(friend[:attributes][:request_status]).to be_a(String)
      end

    end
  end

  describe 'updating a friend relationship' do
    describe 'happy path' do
      it 'can update the status of a friend relationship after the requestee accepts the request' do
        friendship = create(:friend)
        other_friendships = create_list(:friend, 3)
        expect(friendship.request_status).to eq('pending')

        params = { request_status: 'accepted' }

        patch "/api/v2/friends/#{friendship.id}", params: params

        other_friendships.each do |other|
          expect(other.request_status).to eq('pending')
        end

        accepted_friendship = Friend.first

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(accepted_friendship.id).to eq(friendship.id)
        expect(accepted_friendship.follower_id).to eq(friendship.follower_id)
        expect(accepted_friendship.followee_id).to eq(friendship.followee_id)
        expect(accepted_friendship.request_status).to eq('accepted')
      end

      it 'can update the status of a friend relationship after the requestee rejects the request' do
        friendship = create(:friend)
        other_friendships = create_list(:friend, 3)
        expect(friendship.request_status).to eq('pending')

        params = { request_status: 'rejected' }

        patch "/api/v2/friends/#{friendship.id}", params: params

        other_friendships.each do |other|
          expect(other.request_status).to eq('pending')
        end

        rejected_friendship = Friend.first

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(rejected_friendship.id).to eq(friendship.id)
        expect(rejected_friendship.follower_id).to eq(friendship.follower_id)
        expect(rejected_friendship.followee_id).to eq(friendship.followee_id)
        expect(rejected_friendship.request_status).to eq('rejected')
      end

      it 'sends back the information about the updated friendship to the front end if friendship is accepted' do
        friendship = create(:friend)
        other_friendships = create_list(:friend, 3)
        expect(friendship.request_status).to eq('pending')

        params = { request_status: 'accepted' }

        patch "/api/v2/friends/#{friendship.id}", params: params

        other_friendships.each do |other|
          expect(other.request_status).to eq('pending')
        end

        expect(response).to be_successful

        friend_data = JSON.parse(response.body, symbolize_names: true)
        friend = friend_data[:data]

        expect(friend[:id]).to eq(friendship.followee_id)
        expect(friend[:type]).to eq("friend_followee")
        expect(friend[:attributes][:name]).to be_a(String)
        expect(friend[:attributes][:email]).to be_a(String)
        expect(friend[:attributes][:google_id]).to be_a(String)
        expect(friend[:attributes][:request_status]).to be_a(String)
        expect(friend[:attributes][:request_status]).to_not eq(friendship.request_status)
        expect(friend[:attributes][:request_status]).to eq("accepted")
      end
      
      it 'sends back the information about the updated friendship to the front end if friendship is rejected' do
        friendship = create(:friend)
        other_friendships = create_list(:friend, 3)
        expect(friendship.request_status).to eq('pending')

        params = { request_status: 'rejected' }

        patch "/api/v2/friends/#{friendship.id}", params: params

        other_friendships.each do |other|
          expect(other.request_status).to eq('pending')
        end

        expect(response).to be_successful

        friend_data = JSON.parse(response.body, symbolize_names: true)
        friend = friend_data[:data]
   
        expect(friend[:id]).to eq(friendship.followee_id)
        expect(friend[:type]).to eq("friend_followee")
        expect(friend[:attributes][:name]).to be_a(String)
        expect(friend[:attributes][:email]).to be_a(String)
        expect(friend[:attributes][:google_id]).to be_a(String)
        expect(friend[:attributes][:request_status]).to be_a(String)
        expect(friend[:attributes][:request_status]).to_not eq(friendship.request_status)
        expect(friend[:attributes][:request_status]).to eq("rejected")
      end

    end
  end
end
