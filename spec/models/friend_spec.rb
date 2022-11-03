require 'rails_helper'

RSpec.describe Friend do

  describe 'validations' do
    it { should validate_presence_of :follower_id }
    it { should validate_numericality_of :follower_id }
      
    it { should validate_presence_of :followee_id }
    it { should validate_numericality_of :followee_id }

    it { should validate_presence_of :request_status }
    # it { should validate_numericality_of :request_status }

    it { should define_enum_for(:request_status).with_values([:pending, :accepted, :rejected])}
  end

  describe 'relationships' do
    it { should belong_to :followee}
    it { should belong_to :follower}
  end

  describe 'instance methods' do
    describe '#accepted_friends' do
      user = create(:user)

      accepted_friends = create_list(:friends, 3, follower: user, status: 1)
      rejected_friends = create_list(:friends, 3, follower: user, status: 2)
      pending_friends = create_list(:friends, 3, follower: user, status: 0)
    end
  end

end