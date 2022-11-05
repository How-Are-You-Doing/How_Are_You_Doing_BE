require 'rails_helper'

RSpec.describe ToneService do
  describe "API endpoint" , VCR.turn_off! do
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
    it 'can get the emotional tone of a sentance/s pased to it' do
      tone_data  = ToneService.get_tone("Today I got a job offer for the company that I really loved, and have admired for a long time.")

      expect(tone_data).to be_a(Hash)
      expect(tone_data).to have_key(:emotion_scores)
      expect(tone_data[:emotion_scores]).to be_a(Hash)

      expect(tone_data[:emotion_scores]).to have_key(:joy)
      expect(tone_data[:emotion_scores][:joy]).to be_an(Numeric)

      expect(tone_data[:emotion_scores]).to have_key(:surprise)
      expect(tone_data[:emotion_scores][:surprise]).to be_an(Numeric)

      expect(tone_data[:emotion_scores]).to have_key(:disgust)
      expect(tone_data[:emotion_scores][:disgust]).to be_an(Numeric)

      expect(tone_data[:emotion_scores]).to have_key(:sadness)
      expect(tone_data[:emotion_scores][:sadness]).to be_an(Numeric)

      expect(tone_data[:emotion_scores]).to have_key(:anger)
      expect(tone_data[:emotion_scores][:anger]).to be_an(Numeric)

      expect(tone_data[:emotion_scores]).to have_key(:fear)
      expect(tone_data[:emotion_scores][:fear]).to be_an(Numeric)

    end
  end
end