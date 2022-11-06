require 'rails_helper'

describe 'Users API' do
  describe 'creating a new user' do
    describe 'happy path' do
      it 'Can create a new user' do
        user = create(:user)

        headers = { HTTP_NAME: 'Green Goblin',
                    HTTP_EMAIL: 'greenestgobble@gmail.com',
                    HTTP_GOOGLE_ID: '225826428274681000'
                  }

        post '/api/v1/users', headers: headers
        created_user = User.last

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_user.name).to eq(headers[:HTTP_NAME])
        expect(created_user.email).to eq(headers[:HTTP_EMAIL])
        expect(created_user.google_id).to eq(headers[:HTTP_GOOGLE_ID])
      end
    end
  end
end
