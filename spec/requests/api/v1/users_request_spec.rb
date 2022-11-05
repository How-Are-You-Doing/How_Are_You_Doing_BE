require 'rails_helper'

describe "Users API" do
  describe "creating a new user" do


    describe "happy path" do
      it "Can create a new user" do
        user = create(:user)

        headers = ({
                    HTTP_NAME: 'Green Goblin',
                    HTTP_EMAIL: 'greenestgobble@gmail.com',
                    HTTP_GOOGLE_ID: "225826428274681000",
                  })

        post "/api/v1/users", headers: headers
        created_user = User.last
       
        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_user.name).to eq(headers[:HTTP_NAME])
        expect(created_user.email).to eq(headers[:HTTP_EMAIL])
        expect(created_user.google_id).to eq(headers[:HTTP_GOOGLE_ID])
      end
    end
  end

  describe 'user index' do
    describe 'happy path' do
      it 'can find a user given an email param' do
        u1 = create(:user)
        u2 = create(:user)
      
        headers = ({email: u1.email})
        
        get "/api/v1/users?email=#{u1.email}"
      
        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        user = user_data[:data]

        expect(user[:id].to_i).to eq(u1.id)
        expect(user[:type]).to eq("user")
        expect(user[:attributes].count).to eq(1)
        expect(user[:attributes][:name]).to eq(u1.name)
      end
    end

    describe 'sad path' do
      it 'returns an empty array if there is no user by that email' do
        u1 = create(:user)
        u2 = create(:user)
      
        headers = ({email: u1.email})
        
        get "/api/v1/users?email=iamrickjames@superfreak.com"

        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        expect(user_data).to eq({:data=>[]})
      end
    end

    describe 'happy path' do
      it 'can find a user given a google id as a param' do
        u1 = create(:user)
      
        # headers = ({email: u1.google_id})
        
        get "/api/v1/users?search=#{u1.google_id}" #was taken from the seed file google_id list
      
        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        user = user_data[:data]
require 'pry' ; binding.pry
        expect(user[:id].to_i).to eq(u1.id)
        expect(user[:type]).to eq("user")
        expect(user[:attributes].count).to eq(3)
        expect(user[:attributes][:name]).to eq(u1.name)
        expect(user[:attributes][:email]).to eq(u1.email)
        expect(user[:attributes][:google_id]).to eq(u1.google_id)
      end
    end

    describe 'sad path' do
      it 'returns an empty array if there is no user by that google id' do
        u1 = create(:user)
      
        # headers = ({email: u1.email})
        
        get "/api/v1/users?search=000000000000"

        expect(response).to be_successful

        user_data = JSON.parse(response.body, symbolize_names: true)
        expect(user_data).to eq({:data=>[]})
      end
    end
  end
end
