require 'rails_helper'

describe 'Users API' do
  describe 'creating a new user' do
    describe 'happy path' do
      it 'Can create a new user' do
        user = create(:user)

        params = {  name: 'Green Goblin',
                    email: 'greenestgobble@gmail.com',
                    google_id: '225826428274681000' }

        post '/api/v2/users', params: params
        created_user = User.last

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_user.name).to eq(params[:name])
        expect(created_user.email).to eq(params[:email])
        expect(created_user.google_id).to eq(params[:google_id])
      end
    end
  end

  describe 'user index' do
    describe 'happy path' do
      it 'can find a user given an email param' do
        u1 = create(:user)
        u2 = create(:user)

        params = { email: u1.email }

        get '/api/v2/users', params: params

        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        user = user_data[:data]

        expect(user_data[:data]).to be_a(Hash)
        expect(user[:id].to_i).to eq(u1.id)
        expect(user[:type]).to eq('user')
        expect(user[:attributes].count).to eq(3)
        expect(user[:attributes][:name]).to eq(u1.name)
        expect(user[:attributes][:email]).to eq(u1.email)
        expect(user[:attributes][:google_id]).to eq(u1.google_id)
      end
    end

    describe 'sad path' do
      it 'returns an empty array if there is no user by that email' do
        create_list(:user, 3)

        params = { email: 'iamrickjames@superfreak.com' }

        get '/api/v2/users', params: params

        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        expect(user_data).to eq({ data: {} })
      end
    end
  end
end
