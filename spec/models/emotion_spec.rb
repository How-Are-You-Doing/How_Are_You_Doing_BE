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
    describe '#get_definitions' do
      before :each do
        @emotion_1 = Emotion.create!(term: 'contemplative')
        @emotion_2 = Emotion.create!(term: 'forlorn')
        @emotion_3 = Emotion.create!(term: 'thrilled')
      end

      it 'updates emotions in the data base to add a definition to each emotion', vcr: { record: :new_episodes } do
        expect(Emotion.find(@emotion_1.id).definition).to eq(nil)
        expect(Emotion.find(@emotion_2.id).definition).to eq(nil)

        Emotion.get_definitions

        expect(Emotion.find(@emotion_1.id).definition).to_not eq(nil)
        expect(Emotion.find(@emotion_2.id).definition).to be_a(String)
      end

      it 'does not update emotions that already have a definition in the database', vcr: { record: :new_episodes } do
        emotion_4 = Emotion.create!(term: 'disquiet',
                                    definition: 'Lack of quiet; absence of tranquility in body or mind', 
                                    created_at: '2022-8-12', 
                                    updated_at: '2022-8-12')

        emotion_5 = Emotion.create!(term: 'proud', 
                                    created_at: '2022-8-12', 
                                    updated_at: '2022-8-12')

        expect(Emotion.find(emotion_4.id).updated_at).to eq(DateTime.parse('2022-8-12'))
        expect(Emotion.find(emotion_5.id).updated_at).to eq(DateTime.parse('2022-8-12'))

        Emotion.get_definitions

        expect(Emotion.find(emotion_4.id).updated_at).to eq(DateTime.parse('2022-8-12'))
        expect(Emotion.find(emotion_5.id).updated_at).to_not eq(DateTime.parse('2022-8-12'))
      end
    end
  end
end
