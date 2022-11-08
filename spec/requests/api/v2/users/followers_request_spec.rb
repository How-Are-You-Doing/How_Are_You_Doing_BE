require 'rails_helper'

describe 'User Followers API' do
  describe 'Followers Index' do
    describe 'happy path' do
      it 'sends a list of all of users who are following the logged in user regardless of request status' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { 'user' => "#{user.google_id}" }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        follower_data = JSON.parse(response.body, symbolize_names: true)

        followers = follower_data[:data]
        expect(followers.count).to eq(9)

        followers.each do |follower|
          expect(follower[:id].to_i).to be_a(Integer)
          expect(follower[:friendship_id].to_i).to be_a(Integer)
          expect(follower[:type]).to eq('friend_follower')
          expect(follower[:attributes].count).to eq(3)
          expect(follower[:attributes][:name]).to be_a(String)
          expect(follower[:attributes][:email]).to be_a(String)
          expect(follower[:attributes][:google_id]).to be_a(String)
        end
      end

      it 'sends a list of all followers a user has accepted a follow request from' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'accepted' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)

        followers = followers_data[:data]
        expect(followers.count).to eq(3)
        expect(accepted_followers.first.follower_id).to eq(followers.first[:id].to_i)
        expect(accepted_followers.last.follower_id).to eq(followers.last[:id].to_i)

        followers.each do |follower|
          expect(follower[:id].to_i).to be_a(Integer)
          expect(follower[:friendship_id].to_i).to be_a(Integer)
          expect(follower[:type]).to eq('friend_follower')
          expect(follower[:attributes].count).to eq(3)
          expect(follower[:attributes][:name]).to be_a(String)
          expect(follower[:attributes][:email]).to be_a(String)
          expect(follower[:attributes][:google_id]).to be_a(String)
        end
      end

      it 'sends a list of all of followers a user has pending follow request' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'pending' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)

        followers = followers_data[:data]
        expect(followers.count).to eq(3)
        expect(pending_followers.first.follower_id).to eq(followers.first[:id].to_i)
        expect(pending_followers.last.follower_id).to eq(followers.last[:id].to_i)

        followers.each do |follower|
          expect(follower[:id].to_i).to be_a(Integer)
          expect(follower[:friendship_id].to_i).to be_a(Integer)
          expect(follower[:type]).to eq('friend_follower')
          expect(follower[:attributes].count).to eq(3)
          expect(follower[:attributes][:name]).to be_a(String)
          expect(follower[:attributes][:email]).to be_a(String)
          expect(follower[:attributes][:google_id]).to be_a(String)
        end
      end

      it 'sends a list of all of a users followers that have rejected their request' do
        user = create(:user)

        accepted_followers = create_list(:friend, 3, followee: user, request_status: 1)
        rejected_followers = create_list(:friend, 3, followee: user, request_status: 2)
        pending_followers = create_list(:friend, 3, followee: user, request_status: 0)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'rejected' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)

        followers = followers_data[:data]

        expect(followers.count).to eq(3)
        expect(rejected_followers.first.follower_id).to eq(followers.first[:id].to_i)
        expect(rejected_followers.last.follower_id).to eq(followers.last[:id].to_i)

        followers.each do |follower|
          expect(follower[:id].to_i).to be_a(Integer)
          expect(follower[:friendship_id].to_i).to be_a(Integer)
          expect(follower[:type]).to eq('friend_follower')
          expect(follower[:attributes].count).to eq(3)
          expect(follower[:attributes][:name]).to be_a(String)
          expect(follower[:attributes][:email]).to be_a(String)
          expect(follower[:attributes][:google_id]).to be_a(String)
        end
      end
    end

    describe 'sad path' do
      it 'sends a 400 error if no user google_id recived in params for a user' do
        randos = create_list(:friend, 5)

        get '/api/v2/users/followers'

        expect(response).to have_http_status(400)
        
        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end

      it 'sends a 400 error if no user google_id recived in params for a user but request status param is sent' do
        randos = create_list(:friend, 5)

        params = { request_status: 'accepted' }

        get '/api/v2/users/followers', params: params

        expect(response).to have_http_status(400)

        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for all followers' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}" }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for accepted followers' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'accepted' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for pending followers' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'pending' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end

      it 'sends an empty data hash back if there are no matches for rejected followers' do
        user = create(:user)
        randos = create_list(:friend, 5)

        params = { user: "#{user.google_id}",
                   request_status: 'rejected' }

        get '/api/v2/users/followers', params: params

        expect(response).to be_successful

        followers_data = JSON.parse(response.body, symbolize_names: true)
        expect(followers_data).to eq({ data: [] })
      end
    end
  end
end
