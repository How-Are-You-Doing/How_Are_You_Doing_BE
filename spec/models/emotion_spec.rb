require 'rails_helper'

RSpec.describe Emotion, type: :model do

  describe 'validations' do
    it { should validate_presence_of :term }
    it { should validate_uniqueness_of :term }
    
    it { should validate_presence_of(:definition).on(:update) }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
  end

  describe 'class methods' do
    describe "#get_definitions" do
      before :each do
        @emotion_1 = Emotion.create!(term: "contemplative")
        @emotion_2 = Emotion.create!(term: "forlorn")
        @emotion_3 = Emotion.create!(term: "thrilled")

        allow(Date).to receive(:today).and_return(Date.new(2022,11,30))
      end

      it "updates emotions in the data base to add a definition to each emotion" do
        expect(@emotion_1.definition).to eq(nil)
        expect(@emotion_3.definition).to eq(nil)

        Emotion.get_definitions
        
        expect(@emotion_1.definition).to_not eq(nil)
        expect(@emotion_1.definition).to be_a(String)
      end

      it "does not update emotions that already have a definition in the database" do

        emotion_4 = Emotion.create!(term: "disquiet", definition: "Lack of quiet; absence of tranquility in body or mind", created_at: "2022/8/12", updated_at: "2022/8/12")
        emotion_5 = Emotion.create!(term: "proud", created_at: "2022/8/12", updated_at: "2022/8/12")


        Emotion.get_definitions
        
        expect(emotion_4.updated_at).to eq(DateTime.parse("2022-8-12"))
        expect(emotion_5.updated_at).to eq(DateTime.parse("2022-11-30"))
      end
    end
  end
end