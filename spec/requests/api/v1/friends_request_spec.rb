require 'rails_helper'

describe 'Friends API' do
  describe 'Friends Index' do
    it 'sends a list of all of a users friends that have accepted their request' do
      create_list(:friend, 5, request_status: 1)
      create_list(:friend, 5, request_status: 0)
      create_list(:friend, 5, request_status: 2)

      get "/api/v1/friends"

      expect(response).to be_successful

      friends_data = JSON.parse(response.body, symbolize_names: true)

      friends = friends_data[:data]
    
      expect(friends.count).to eq(5)

      friends.each do |friend|
        expect(friend[:id].to_i).to be_a(Integer)
        expect(friend[:type]).to eq("friend")
        expect(friend[:attributes].count).to eq(3)
        expect(friend[:attributes]).to have_key(:follower_id)
        expect(friend[:attributes]).to have_key(:followee_id)
        expect(friend[:attributes][:request_status]).to eq("accepted")
      end
    end
  end
end