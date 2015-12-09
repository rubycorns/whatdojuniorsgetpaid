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

  describe '.to_csv' do
    before do
      (build :junior_story).save
      (build :junior_story, publishing_consent: false).save
    end

    it 'should contain all JuniorStories with publishing consent including all fields' do
      csv = JuniorStory.to_csv
      rows = csv.split("\n")
      expected_row_count = JuniorStory.where(publishing_consent: true).count + 1 # +1 for header row
      expect(rows.count).to eq(expected_row_count)
      rows.each do |row|
        expect(row.split(',').count).to eq(JuniorStory.attribute_names.count)
      end
    end
  end
end
