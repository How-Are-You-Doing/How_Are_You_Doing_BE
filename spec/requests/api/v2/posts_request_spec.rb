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
      stub_request(:get, 'https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/?text=Today%20I%20got%20a%20job%20offer%20for%20the%20company%20that%20I%20really%20loved,%20and%20have%20admired%20for%20a%20long%20time.')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.6.0',
            'X-Rapidapi-Host' => 'twinword-emotion-analysis-v1.p.rapidapi.com',
            'X-Rapidapi-Key' => ENV['tone_api_key']
          }
        )
        .to_return(status: 200, body: json_response, headers: {})
    end
    describe 'happy path' do
      it 'Creates a new user post' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')

        params = {  user: user.google_id,
                    emotion: emotion.term,
                    description: 'Today I got a job offer for the company that I really loved, and have admired for a long time.',
                    post_status: 'shared' }

        post '/api/v2/posts', params: params

        expect(response).to be_successful
        expect(response).to have_http_status(201)
        post_data = JSON.parse(response.body, symbolize_names: true)
        post = post_data[:data]

        created_post = user.posts.last

        expect(created_post.emotion_id).to eq(emotion.id)
        expect(created_post.description).to eq(params[:description])
        expect(created_post.tone).to_not be(nil)

        expect(post_data).to be_a(Hash)
        expect(post_data.count).to eq(1)

        expect(post[:id].to_i).to eq(created_post.id)
        expect(post[:type]).to eq('post')
        expect(post[:attributes].count).to eq(5)
        expect(post[:attributes][:emotion]).to eq(params[:emotion])
        expect(post[:attributes][:post_status]).to eq(created_post.post_status)
        expect(post[:attributes][:description]).to eq(created_post.description)
        expect(post[:attributes][:tone]).to eq(created_post.tone)
        expect(post[:attributes][:created_at].to_date).to eq(created_post.created_at.to_date)
      end

      it 'Creates a new user post with a personal status if not post status is provided' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')

        params = {  user: user.google_id,
                    emotion: emotion.term,
                    description: 'Today I got a job offer for the company that I really loved, and have admired for a long time.' }

        post '/api/v2/posts', params: params

        expect(response).to be_successful
        expect(response).to have_http_status(201)
        post_data = JSON.parse(response.body, symbolize_names: true)
        require 'pry'
        binding.pry
        post = post_data[:data]
        created_post = user.posts.last

        expect(created_post.emotion_id).to eq(emotion.id)
        expect(created_post.description).to eq(params[:description])
        expect(created_post.tone).to_not be(nil)
        expect(created_post.post_status).to eq('personal')

        expect(post_data).to be_a(Hash)
        expect(post_data.count).to eq(1)

        expect(post[:id].to_i).to eq(created_post.id)
        expect(post[:type]).to eq('post')
        expect(post[:attributes].count).to eq(5)
        expect(post[:attributes][:emotion]).to eq(params[:emotion])
        expect(post[:attributes][:post_status]).to eq(created_post.post_status)
        expect(post[:attributes][:description]).to eq(created_post.description)
        expect(post[:attributes][:tone]).to eq(created_post.tone)
        expect(post[:attributes][:created_at].to_date).to eq(created_post.created_at.to_date)
      end
    end
    describe 'sad path' do
      it 'It wont create a new user if required params are missing' do
        user = create(:user)
        emotion = create(:emotion, term: 'thrilled')

        params = {  user: user.google_id,
                    description: 'Today I got a job offer for the company that I really loved, and have admired for a long time.' }

        post '/api/v2/posts', params: params

        post = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(post).to have_key(:data)
        expect(post[:data]).to be_a(Hash)
      end
    end
  end

  describe 'update a user post' do
    before :each do
      json_response = File.read('spec/fixtures/tone_analysis_2.json')
      stub_request(:get, "https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/?text=I%20have%20not%20been%20able%20to%20sleep%20very%20well%20lately%20because%20my%20dog%20is%20at%20the%20vet%20sick%20and%20we%20have%20a%20huge%20project%20at%20work%20that%20is%20taking%20a%20lot%20of%20time%20so%20I%20cant%20be%20with%20him%20at%20the%20vet.")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.6.0',
            'X-Rapidapi-Host' => 'twinword-emotion-analysis-v1.p.rapidapi.com',
            'X-Rapidapi-Key' => ENV['tone_api_key']
          }
        )
        .to_return(status: 200, body: json_response, headers: {})
    end

    describe 'happy path' do
      it 'Updates an existing user post when all new post info is rcvd' do
        user = create(:user)
        post = create(:post, user: user, post_status: 'personal')
        emotion = create(:emotion, term: 'Annoyed')

        params = {  emotion: emotion.term,
                    description: 'I have not been able to sleep very well lately because my dog is at the vet sick and we have a huge project at work that is taking a lot of time so I cant be with him at the vet.',
                    post_status: 'shared' }

        patch "/api/v2/posts/#{post.id}", params: params

        expect(response).to be_successful
        post_response = JSON.parse(response.body, symbolize_names: true)

        post_data = post_response[:data]
        updated_post = user.posts.find(post.id)

        expect(updated_post.emotion_id).to eq(emotion.id)
        expect(updated_post.description).to eq(params[:description])
        expect(updated_post.tone).to_not be(post.tone)

        expect(post_response).to be_a(Hash)
        expect(post_response.count).to eq(1)
        expect(post_data[:id].to_i).to eq(post.id)
        expect(post_data[:type]).to eq('post')
        expect(post_data[:attributes].count).to eq(5)

        expect(post_data[:attributes][:emotion]).to eq(emotion.term)
        expect(post_data[:attributes][:emotion]).to_not eq(Emotion.find(post.emotion_id).term)

        expect(post_data[:attributes][:post_status]).to eq(updated_post.post_status)
        expect(post_data[:attributes][:post_status]).to_not eq(post.post_status)

        expect(post_data[:attributes][:description]).to eq(updated_post.description)
        expect(post_data[:attributes][:description]).to_not eq(post.description)

        expect(post_data[:attributes][:tone]).to eq(updated_post.tone)
        expect(post_data[:attributes][:tone]).to_not eq(post.tone)

        expect(post_data[:attributes][:created_at].to_date).to eq(post.created_at.to_date)
      end

      it 'Updates an existing user post when some new post info is rcvd' do
        user = create(:user)
        post = create(:post, user: user)

        params = {  
                    description: 'I have not been able to sleep very well lately because my dog is at the vet sick and we have a huge project at work that is taking a lot of time so I cant be with him at the vet.',
                   }

        patch "/api/v2/posts/#{post.id}", params: params

        expect(response).to be_successful
        post_response = JSON.parse(response.body, symbolize_names: true)

        post_data = post_response[:data]
        updated_post = user.posts.find(post.id)

        expect(updated_post.emotion_id).to eq(post.emotion_id)
        expect(updated_post.description).to eq(params[:description])
        expect(updated_post.tone).to_not be(post.tone)

        expect(post_response).to be_a(Hash)
        expect(post_response.count).to eq(1)
        expect(post_data[:id].to_i).to eq(post.id)
        expect(post_data[:type]).to eq('post')
        expect(post_data[:attributes].count).to eq(5)

        expect(post_data[:attributes][:emotion]).to eq(Emotion.find(post.emotion_id).term)
        expect(post_data[:attributes][:post_status]).to eq(post.post_status)

        expect(post_data[:attributes][:description]).to eq(updated_post.description)
        expect(post_data[:attributes][:description]).to_not eq(post.description)

        expect(post_data[:attributes][:tone]).to eq(updated_post.tone)
        expect(post_data[:attributes][:tone]).to_not eq(post.tone)

        expect(post_data[:attributes][:created_at].to_date).to eq(post.created_at.to_date)
      end

      it 'Does not update tone an existing user post when same description is recived with new post info' do
        user = create(:user)
        post = create(:post, user: user, post_status: 'personal')
        emotion = create(:emotion, term: 'Annoyed')

        params = {  emotion: emotion.term,
                    description: post.description,
                    post_status: 'shared' }

        patch "/api/v2/posts/#{post.id}", params: params

        expect(response).to be_successful
        post_response = JSON.parse(response.body, symbolize_names: true)

        post_data = post_response[:data]
        updated_post = user.posts.find(post.id)

        expect(updated_post.emotion_id).to eq(emotion.id)
        expect(updated_post.description).to eq(post.description)
        expect(updated_post.tone).to eq(post.tone)

        expect(post_response).to be_a(Hash)
        expect(post_response.count).to eq(1)
        expect(post_data[:id].to_i).to eq(post.id)
        expect(post_data[:type]).to eq('post')
        expect(post_data[:attributes].count).to eq(5)

        expect(post_data[:attributes][:emotion]).to eq(emotion.term)
        expect(post_data[:attributes][:emotion]).to_not eq(post.emotion)

        expect(post_data[:attributes][:post_status]).to eq(updated_post.post_status)
        expect(post_data[:attributes][:post_status]).to_not eq(post.post_status)

        expect(post_data[:attributes][:description]).to eq(post.description)

        expect(post_data[:attributes][:tone]).to eq(post.tone)

        expect(post_data[:attributes][:created_at].to_date).to eq(updated_post.created_at.to_date)
      end

    end

    describe 'sad path' do
      it 'It wont update a post if the only updated param sent is and empty description string' do
        post = create(:post)

        params = { description: ' ' }

        patch "/api/v2/posts/#{post.id}", params: params

        post = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(post).to have_key(:data)
        expect(post[:data]).to be_a(Hash)
      end

      it 'It wont update a post if no params sent is and empty description string' do
        post = create(:post)

        patch "/api/v2/posts/#{post.id}"

        post = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)

        expect(post).to have_key(:data)
        expect(post[:data]).to be_a(Hash)
      end
    end
  end
end
