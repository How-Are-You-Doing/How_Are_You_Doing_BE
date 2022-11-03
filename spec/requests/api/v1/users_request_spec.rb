require 'rails_helper'

describe "Users API" do
  describe "creating a new user" do


    describe "happy path" do
      it "Can create a new user" do
        user = create(:user)

        headers = ({
                    name: 'Green Goblin',
                    email: 'greenestgobble@gmail.com',
                    google_id: "225826428274681000",
                  })

        post "/api/v1/users", headers: headers
        created_user = User.last

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_user.name).to eq(headers[:name])
        expect(created_user.email).to eq(headers[:email])
        expect(created_user.google_id).to eq(headers[:google_id])
      end
    end
  end
end