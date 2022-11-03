require 'rails_helper'

describe "Users API" do
  describe "creating a new user" do


    describe "happy path" do
      it "Can create a new user" do
        user = create(:user)

        new_user_params = ({
                              name: 'Green Goblin',
                              email: 'greenestgobble@gmail.com',
                              phone_number: "225-555-1000",
                            })
        # headers = {"Content-Type" => "application/json"} not sure if i need this - get this from Carter

        post "/api/v1/users", headers: headers, params: JSON.generate(item: new_user_params)
        created_user = User.last

        expect(response).to be_successful
        expect(response.status).to eq(201)

        expect(created_user.name).to eq(new_user_params[:name])
        expect(created_user.email).to eq(new_user_params[:email])
        expect(created_user.phone_number).to eq(new_user_params[:phone_number])
      end
    end

    describe 'sad path' do
      it "can render a 404 error if the user can not be created because of an invalid datatype" do
        user = create(:user)

        new_user_params = ({
                              name: 28562, #invalid datatype
                              email: 'greenestgobble@gmail.com',
                              phone_number: "225-555-1000",
                            })
        # headers = {"Content-Type" => "application/json"} not sure if i need this - get this from Carter
  
        post "/api/v1/users", headers: headers, params: JSON.generate(item: new_user_params)
  
        expect(response).to_not be_successful  
        expect(response.status).to eq(404)
        expect(User.last.email).to_not eq("greenestgobble@gmail.com")
      end

      it "edge case: it can render a 404 error if all attributes are missing" do

        new_user_params = ({
                            name: '', 
                            email: '',
                            phone_number: '',
                          })
        headers = {"Content-Type" => "application/json"}

        post "/api/v1/users", headers: headers, params: JSON.generate(item: new_user_params)

        expect(response.status).to eq(404)
      end
    end

  end
end