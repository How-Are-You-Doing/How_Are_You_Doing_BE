require "rails_helper"

RSpec.describe DefinitionFacade do
  it "can find definitions for word provided" , vcr: {record: :new_episodes} do
    definition = DefinitionFacade.find_definition("thrilled")

    expect(definition).to be_a(String)
  end
end