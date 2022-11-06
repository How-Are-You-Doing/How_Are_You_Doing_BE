require 'rails_helper'

describe 'Posts API' do
  describe 'user post index' do
    describe 'happy path' do
      it 'sends a list of all posts for a user' do
        user = create(:user)
        posts = create_list(:post, 5, user: user)

        params = { user: "#{user.google_id}" }

        get '/api/v2/users/history', params: params

        expect(response).to be_successful

        posts = JSON.parse(response.body, symbolize_names: true)

        expect(posts[:data].count).to eq(5)

        posts[:data].each do |post|
          expect(post).to have_key(:id)
          expect(post[:id]).to be_a(String)

          expect(post).to have_key(:type)
          expect(post[:type]).to be_a(String)

          expect(post).to have_key(:attributes)
          expect(post[:attributes]).to be_a(Hash)

          expect(post[:attributes]).to have_key(:emotion)
          expect(post[:attributes][:emotion]).to be_a(String)

          expect(post[:attributes]).to have_key(:post_status)
          expect(post[:attributes][:post_status]).to be_a(String)

          expect(post[:attributes]).to have_key(:description)
          expect(post[:attributes][:description]).to be_a(String)

          expect(post[:attributes]).to have_key(:tone)
          expect(post[:attributes][:tone]).to be_a(String)

          expect(post[:attributes]).to have_key(:created_at)
          expect(post[:attributes][:created_at]).to be_a(String)
        end
      end
    end

    describe 'sad path' do
      it 'sends a 400 error if no user google_id recived in params for a user' do
        user = create(:user)
        posts = create_list(:post, 5, user: user)

        get '/api/v2/users/history'

        posts = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(posts).to have_key(:data)
        expect(posts[:data]).to be_a(Hash)
      end

      it 'sends a empty array is user has no posts' do
        user = create(:user)

        params = { user: "#{user.google_id}" }

        get '/api/v2/users/history', params: params

        posts = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(posts).to have_key(:data)
        expect(posts[:data]).to be_an(Array)
      end

      it 'sends a empty data hash if google_id for user is not found' do
        user = create(:user)

        params = { user: '65' }

        get '/api/v2/users/history', params: params

        posts = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(posts).to have_key(:data)
        expect(posts[:data]).to be_an(Hash)
      end
    end
  end
end
