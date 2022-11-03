class DefinitionFacade
  def self.find_definition(word)
    definition_data = DefinitionService.get_definition(word)
    definition_data[0][:meanings][0][:definitions][0][:definition]
  end
end