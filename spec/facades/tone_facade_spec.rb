require 'rails_helper'

RSpec.describe DefinitionFacade do
  describe 'Emotion Tone facade methods', VCR.turn_off! do
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

    it 'can find the highest score emotion found within a sentance/s provided' do
      tone = ToneFacade.analyze_tone('Today I got a job offer for the company that I really loved, and have admired for a long time.')

      expect(tone).to be_a(String)
    end
  end
end
