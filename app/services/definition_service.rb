class DefinitionService
  def self.get_definition(word)
    response = conn.get("/api/v2/entries/en/#{word}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://api.dictionaryapi.dev')
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
