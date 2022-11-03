require 'rails_helper'

describe 'Friends API' do
  describe 'Friends Index' do
    it 'sends a list of all of a users friends that have accepted their request' do
      user = create(:user)

      accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
      rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
      pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
      randos = create_list(:friend, 5)

      headers = {"HTTP_USER" => "#{user.google_id}"}

      get "/api/v1/friends", headers: headers
      
      expect(response).to be_successful
     
      
      friends_data = JSON.parse(response.body, symbolize_names: true)

      friends = friends_data[:data]
      expect(friends.count).to eq(3)
      expect(accepted_friends.first.followee_id).to eq(friends.first[:id].to_i)
      expect(accepted_friends.last.followee_id).to eq(friends.last[:id].to_i)


      friends.each do |friend|
        expect(friend[:id].to_i).to be_a(Integer)
        expect(friend[:type]).to eq("user")
        expect(friend[:attributes].count).to eq(2)
        expect(friend[:attributes][:name]).to be_a(String)
        expect(friend[:attributes][:email]).to be_a(String)
      end
    end
  end
end