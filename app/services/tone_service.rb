class ToneService
  def self.get_tone(description)
    response = conn.get("/analyze/?text=#{description}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://twinword-emotion-analysis-v1.p.rapidapi.com') do |f|
      f.headers['X-RapidAPI-Key'] = ENV['tone_api_key']
      f.headers['X-RapidAPI-Host'] = 'twinword-emotion-analysis-v1.p.rapidapi.com'
    end
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
