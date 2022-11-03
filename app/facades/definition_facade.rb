class DefinitionFacade
  def self.find_definition(word)
    definition_data = DefinitionService.get_definition(word)
    definition = definition_data[:meanings][0][:definitions][0][:definition]
    require "pry"; binding.pry
  end
end