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
      junior_story.save
      another_junior_story = build :junior_story
      another_junior_story.save
    end

    it 'should contain all JuniorStories with all fields' do
      csv = JuniorStory.to_csv
      rows = csv.split("\n")
      expect(rows.count).to eq(3)
      rows.each do |row|
        expect(row.split(',').count).to eq(JuniorStory.attribute_names.count)
      end
    end
  end

  describe '#to_csv' do
    before do
      junior_story.save
    end

    it 'creates a csv for one juniorstory' do
      csv = junior_story.to_csv
      rows = csv.split("\n")
      expect(rows.count).to eq(2)
      rows.each do |row|
        expect(row.split(',').count).to eq(JuniorStory.attribute_names.count)
      end
    end
  end
end
