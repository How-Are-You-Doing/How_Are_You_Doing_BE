require 'rails_helper'

describe 'Posts API' do
  before :each do
    Faker::UniqueGenerator.clear
  end
  describe 'user most recent post/ post show' do
    describe 'happy path' do
      it 'returns a users most recent post if a user has posts' do
        user = create(:user)
        oldest_post = create(:post, user: user, created_at: 100.day.ago)
        middle_post = create(:post, user: user, created_at: 50.day.ago)
        newest_post = create(:post, user: user, created_at: 1.day.ago)
        create_list(:post, 5)

        params = { user: "#{user.google_id}" }

        get '/api/v2/posts/last', params: params

        expect(response).to be_successful

        post_data = JSON.parse(response.body, symbolize_names: true)
        post = post_data[:data]

        expect(post_data).to be_a(Hash)
        expect(post_data.count).to eq(1)

        expect(post[:id].to_i).to eq(newest_post.id)
        expect(post[:type]).to eq('post')
        expect(post[:attributes].count).to eq(5)
        expect(post[:attributes][:emotion]).to eq(newest_post.emotion.term)
        expect(post[:attributes][:post_status]).to eq(newest_post.post_status)
        expect(post[:attributes][:description]).to eq(newest_post.description)
        expect(post[:attributes][:tone]).to eq(newest_post.tone)
        expect(post[:attributes][:created_at].to_date).to eq(newest_post.created_at.to_date)
      end
    end

    describe 'sad path' do
      it 'returns an empty array if a user has no posts' do
        user = create(:user)
        create_list(:post, 5)

        params = { user: "#{user.google_id}" }

        get '/api/v2/posts/last', params: params

        expect(response).to be_successful

        post_data = JSON.parse(response.body, symbolize_names: true)

        expect(post_data).to eq({ data: {} })
      end
    end
  end

  describe 'create a user post', VCR.turn_off! do
    before :each do 
      json_response = File.read('spec/fixtures/tone_analysis.json')
      stub_request(:get, "https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/?text=Today%20I%20got%20a%20job%20offer%20for%20the%20company%20that%20I%20really%20loved,%20and%20have%20admired%20for%20a%20long%20time.").
         with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.6.0',
              'X-Rapidapi-Host'=>'twinword-emotion-analysis-v1.p.rapidapi.com',
              'X-Rapidapi-Key'=> ENV['tone_api_key']
              }).
         to_return(status: 200, body: json_response, headers: {})
    end
    describe 'happy path' do
      it 'Creates a new user post' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')
        
        params = {  user: user.google_id,
                    emotion: emotion.term,
                    description: "Today I got a job offer for the company that I really loved, and have admired for a long time.",
                    post_status: "shared"
                  }

        post '/api/v2/posts', params: params

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        created_post = user.posts.last

        expect(created_post.emotion_id).to eq(emotion.id)
        expect(created_post.description).to eq(params[:description])
        expect(created_post.tone).to_not be(nil)
      end

      it 'Creates a new user post with a personal status if not post status is provided' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')
        
        params = {  user: user.google_id,
                    emotion: emotion.term,
                    description: "Today I got a job offer for the company that I really loved, and have admired for a long time.",
                  }

        post '/api/v2/posts', params: params

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        created_post = user.posts.last

        expect(created_post.emotion_id).to eq(emotion.id)
        expect(created_post.description).to eq(params[:description])
        expect(created_post.tone).to_not be(nil)
        expect(created_post.post_status).to eq('personal')
      end
    end
    describe 'sad path' do
      it 'It wont create a new user if required params are missing' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')
        
        params = {  user: user.google_id,
                    description: "Today I got a job offer for the company that I really loved, and have admired for a long time."
                  }

        post '/api/v2/posts', params: params

        post = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        
        expect(post).to have_key(:data)
        expect(post[:data]).to be_a(Hash)
      end
    end
  end
  VCR.turn_on!
end
