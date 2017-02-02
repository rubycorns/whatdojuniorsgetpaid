require 'rails_helper'

describe JuniorStory do
  let(:junior_story) { build :junior_story }

  describe 'sanitizing values' do
    before do
      junior_story.city = 'berlin     '
      junior_story.gender = '   Female   '
      junior_story.save
      junior_story.reload
    end

    it 'should capitalize the city & remove whitespaces' do
      expect(junior_story.city).to eql 'Berlin'
    end

    it 'should downcase the gender & remove whitespaces' do
      expect(junior_story.gender).to eql 'female'
    end
  end

  describe '#publishable_attributes' do
    let(:junior_story)   { build_stubbed :junior_story, publishing_consent: true, happy_in_job: 'ya, kinda, could be better though'}
    let(:junior_story_2) { build_stubbed :junior_story, publishing_consent: false, happy_in_job: 'my job is amazing!' }

    it 'should correctly remove values if consent is not given' do
      expect(junior_story.publishable_attributes['happy_in_job']).to eql junior_story.happy_in_job
      expect(junior_story_2.publishable_attributes['happy_in_job']).to eql ''
    end
  end

  describe '.to_csv' do
    let!(:junior_story)   { create :junior_story }
    let!(:junior_story_2) { create :junior_story_without_publishing_consent }
    let(:csv)             { JuniorStory.to_csv }
    let(:rows)            { csv.split("\n") }

    it 'should contain the correct number of rows' do
      expected_row_count = JuniorStory.count + 1 # +1 for header row
      expect(rows.count).to eq(expected_row_count)
    end

    it 'should contain the correct attributes' do
      expect(rows.second.split(',').count).to eq(JuniorStory.attribute_names.count)
    end

    it "doesn't contain attributes 'id', 'created_at', 'updated_at' and 'publishing_consent'" do
      expect(rows.first.split(',')).not_to include('id')
      expect(rows.first.split(',')).not_to include('created_at')
      expect(rows.first.split(',')).not_to include('updated_at')
      expect(rows.first.split(',')).not_to include('publishing_consent')
    end

    context 'with publishing consent' do
      it "contains values for attributes that require publishing consent" do
        expect(rows.second.split(',')).to include('I am happy.')
      end
    end

    context 'no publishing consent' do
      it "doesn't contain values for attributes that require publishing consent" do
        expect(rows.third.split(',')).not_to include('I am happy.')
      end
    end
  end

  describe "#person_with_disability_sentence" do
    context "person with disability set to true" do
      let!(:junior_story) { build_stubbed :junior_story, person_with_disability: true }
      specify { expect(junior_story.person_with_disability_sentence).to eq 'I am a person with a disability.' }
    end

    context "person with disability set to false" do
      let!(:junior_story) { build_stubbed :junior_story, person_with_disability: false }
      specify { expect(junior_story.person_with_disability_sentence).to eq nil }
    end
  end
end
