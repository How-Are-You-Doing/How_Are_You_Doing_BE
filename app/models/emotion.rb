class Emotion < ApplicationRecord
  has_many :posts
  validates_presence_of :term
  validates_presence_of :definition, on: :update
  validates_uniqueness_of :term 

  def self.get_definitions
    all.each do |emotion|
      if emotion.definition.nil?
        new_def = DefinitionFacade.find_definition(emotion.term)
        emotion.update(definition: new_def)
      end
    end
  end

end