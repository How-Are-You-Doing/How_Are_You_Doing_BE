require 'rails_helper'

describe 'Emotions API' do
  describe 'emotion index' do
    describe 'happy path' do
      it 'sends a list of all emotions', vcr: {record: :new_episodes} do
        Emotion.create!(term: 'contemplative')
        Emotion.create!(term: 'forlorn')
        Emotion.create!(term: 'thrilled')
        Emotion.create!(term: 'stressed')
        Emotion.create!(term: 'ecstatic')

        get '/api/v1/emotions'

        expect(response).to be_successful

        emotions = JSON.parse(response.body, symbolize_names: true)

        expect(emotions[:data].count).to eq(5)

        emotions[:data].each do |emotion|
          expect(emotion).to have_key(:id)
          expect(emotion[:id]).to be_a(String)

          expect(emotion).to have_key(:type)
          expect(emotion[:type]).to be_a(String)

          expect(emotion).to have_key(:attributes)
          expect(emotion[:attributes]).to be_a(Hash)

          expect(emotion[:attributes]).to have_key(:emotion)
          expect(emotion[:attributes][:emotion]).to be_a(String)
          expect(emotion[:attributes]).to have_key(:definition)
          expect(emotion[:attributes][:definition]).to be_a(String)

          expect(emotion).to_not have_key(:created_at)
          expect(emotion).to_not have_key(:updated_at)
        end
      end
    end

    describe 'sad path' do
      it 'sends a empty list of emotions if there are no emotions' do
        get '/api/v1/emotions'

        expect(response).to be_successful

        emotions = JSON.parse(response.body, symbolize_names: true)

        expect(emotions[:data].count).to eq(0)

        expect(emotions[:data]).to be_an(Array)
      end
    end
  end
end