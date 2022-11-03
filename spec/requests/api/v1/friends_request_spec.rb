require 'rails_helper'

describe 'Friends API' do
  describe 'Friends Index' do
    it 'sends a list of all of a users friends that have accepted their request' do
      user = create(:user)

      accepted_friends = create_list(:friend, 3, follower: user, request_status: 1)
      rejected_friends = create_list(:friend, 3, follower: user, request_status: 2)
      pending_friends = create_list(:friend, 3, follower: user, request_status: 0)
      randos = create_list(:friend, 5)

      get "/api/v1/friends"

      expect(response).to be_successful

      # friends_data = JSON.parse(response.body, symbolize_names: true)

      # friends = friends_data[:data]
    
      

      # friends.each do |friend|

      # end
    end
  end
end