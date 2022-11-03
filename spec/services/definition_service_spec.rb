require 'rails_helper'

RSpec.describe DefinitionService do
  describe "API endpoint" do
    it 'can get a definition of a word', vcr: {record: :new_episodes} do
      word_data  = DefinitionService.get_definition("thrilled")

      expect(word_data).to be_an(Array)
      expect(word_data[0]).to be_a(Hash)

      expect(word_data[0]).to have_key(:meanings)
      expect(word_data[0][:meanings]).to be_an(Array)

      expect(word_data[0][:meanings][0]).to be_a(Hash)
      expect(word_data[0][:meanings][0]).to have_key(:definitions)
      expect(word_data[0][:meanings][0][:definitions]).to be_an(Array)

      expect(word_data[0][:meanings][0][:definitions][0]).to be_a(Hash)
      expect(word_data[0][:meanings][0][:definitions][0]).to have_key(:definition)
      expect(word_data[0][:meanings][0][:definitions][0][:definition]).to be_a(String)

    end
  end
end