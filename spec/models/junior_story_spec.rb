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

  context 'sentences for JuniorStory attributes' do
    describe '#job_sentence' do
      it 'returns correct sentence' do
        junior_story.job = 'Junior-Developer'
        expect(junior_story.job_sentence).to eq 'I am working as a Junior-Developer.'
        junior_story.job = ''
        expect(junior_story.job_sentence).to be_nil
      end
    end

    describe '#gender_sentence' do
      it 'returns correct sentence' do
        junior_story.gender = 'female'
        expect(junior_story.gender_sentence).to eq 'I identify as female.'
        junior_story.gender = ''
        expect(junior_story.gender_sentence).to be_nil
      end
    end

    describe '#person_of_colour_sentence' do
      it 'returns correct sentence' do
        junior_story.person_of_colour = true
        expect(junior_story.person_of_colour_sentence).to eq 'I am a person of colour.'
        junior_story.person_of_colour = ''
        expect(junior_story.person_of_colour_sentence).to be_nil
      end
    end

    describe '#age_sentence' do
      it 'returns correct sentence' do
        junior_story.age = '36'
        expect(junior_story.age_sentence).to eq 'I am 36 years old.'
        junior_story.age = ''
        expect(junior_story.age).to be_nil
      end
    end

    describe '#city_sentence' do
      it 'returns correct sentence' do
        junior_story.city = 'Berlin'
        expect(junior_story.city_sentence).to eq 'I live in the city of Berlin.'
        junior_story.city = ''
        expect(junior_story.city_sentence).to be_nil
      end
    end

    describe '#country_sentence' do
      it 'returns correct sentence' do
        junior_story.country = 'Germany'
        expect(junior_story.country_sentence).to eq 'I live in the country of Germany.'
        junior_story.country = ''
        expect(junior_story.country_sentence).to be_nil
      end
    end

    describe '#education_sentence' do
      it 'returns correct sentence' do
        junior_story.education = 'self-taught'
        expect(junior_story.education_sentence).to eq 'My educational field when it comes to programming is self-taught.'
        junior_story.education = ''
        expect(junior_story.education_sentence).to be_nil
      end
    end

    describe '#freelancer_sentence' do
      it 'returns correct sentence' do
        junior_story.freelancer = 'yes'
        expect(junior_story.freelancer_sentence).to eq 'I am a freelancer.'
        junior_story.freelancer = 'Anything but yes'
        expect(junior_story.freelancer_sentence).to eq 'I am not a freelancer.'
      end
    end

    describe '#first_job_sentence' do
      it 'returns correct sentence' do
        junior_story.first_job = 'yes'
        expect(junior_story.first_job_sentence).to eq 'This is my first junior/intern job.'
        junior_story.first_job = 'Anything but yes and empty'
        expect(junior_story.first_job_sentence).to eq 'This is not my first junior/intern job.'
        junior_story.remote = ''
        expect(junior_story.remote_sentence).to be_nil
      end
    end

    describe '#technology_sentence' do
      it 'returns correct sentence' do
        junior_story.technology = 'Ruby'
        expect(junior_story.technology_sentence).to eq 'My primary technology at work is Ruby.'
        junior_story.technology = ''
        expect(junior_story.technology_sentence).to be_nil
      end
    end

    describe '#focus_sentence' do
      it 'returns correct sentence' do
        junior_story.focus = 'backend'
        expect(junior_story.focus_sentence).to eq 'I am a backend developer.'
        junior_story.focus = ''
        expect(junior_story.focus_sentence).to be_nil
      end
    end

    describe '#years_working_at_job_sentence' do
      it 'returns correct sentence' do
        junior_story.years_working_at_job = '1'
        expect(junior_story.years_working_at_job_sentence).to eq 'I have been working at my current job for 1.'
        junior_story.years_working_at_job = ''
        expect(junior_story.years_working_at_job_sentence).to be_nil
      end
    end

    describe '#years_working_total_sentence' do
      it 'returns correct sentence' do
        junior_story.years_working_total = '2'
        expect(junior_story.years_working_total_sentence).to eq 'I have been working in the industry for 2.'
        junior_story.years_working_total = ''
        expect(junior_story.years_working_total_sentence).to be_nil
      end
    end

    describe '#days_per_week_sentence' do
      it 'returns correct sentence' do
        junior_story.days_per_week = '5'
        expect(junior_story.full_time_sentence).to eq 'I work 5 days per week.'
        junior_story.days_per_week = ''
        expect(junior_story.full_time_sentence).to be_nil
      end
    end

    describe '#remote_sentence' do
      it 'returns correct sentence' do
        junior_story.remote = 'yes'
        expect(junior_story.remote_sentence).to eq 'I work remotely.'
        junior_story.remote = 'Anything but yes and empty'
        expect(junior_story.remote_sentence).to eq 'I do not work remotely.'
        junior_story.remote = ''
        expect(junior_story.remote_sentence).to be_nil
      end
    end

    describe '#company_size_sentence' do
      it 'returns correct sentence' do
        junior_story.company_size = '10'
        expect(junior_story.company_size_sentence).to eq 'My company consists of 10.'
        junior_story.company_size = ''
        expect(junior_story.company_size_sentence).to be_nil
      end
    end

    describe '#tech_team_size_sentence' do
      it 'returns correct sentence' do
        junior_story.tech_team_size = '3'
        expect(junior_story.tech_team_size_sentence).to eq 'My tech team consists of 3.'
        junior_story.tech_team_size = ''
        expect(junior_story.tech_team_size_sentence).to be_nil
      end
    end

    describe '#company_age_sentence' do
      it 'returns correct sentence' do
        junior_story.company_age = '6'
        expect(junior_story.company_age_sentence).to eq 'My company is 6 years old.'
        junior_story.company_age = ''
        expect(junior_story.company_age_sentence).to be_nil
      end
    end

    describe '#salary_sentence' do
      it 'returns correct sentence' do
        junior_story.salary = '1000'
        junior_story.currency= '€'
        expect(junior_story.salary_sentence).to eq 'My salary is 1000 € per year before taxes.'
        junior_story.salary = ''
        junior_story.currency = ''
        expect(junior_story.salary_sentence).to eq 'My salary is   per year before taxes.'
      end
    end

    context 'needing a publishing consent' do
      describe '#happy_in_job_sentence' do
        it 'returns correct sentence' do
          junior_story = build :junior_story, happy_in_job: '3'
          expect(junior_story.happy_in_job_sentence).to eq 'On a scale of 1 - 5, my happiness level in my job is a 3.'
          junior_story.happy_in_job = ''
          expect(junior_story.happy_in_job_sentence).to be_nil
          junior_story.happy_in_job = 'Not to publish'
          junior_story.publishing_consent = false
          expect(junior_story.happy_in_job_sentence).to be_nil
        end
      end

      describe '#happy_info_sentence' do
        it 'returns correct sentence' do
          junior_story = build :junior_story, happy_info: 'The mentors are great'
          expect(junior_story.happy_info_sentence).to eq 'Additional information when it comes to my happiness: The mentors are great.'
          junior_story.happy_info = 'Not to publish'
          junior_story.publishing_consent = false
          expect(junior_story.happy_info_sentence).to be_nil
        end
      end

      describe '#other_sentence' do
        it 'returns correct sentence' do
          junior_story = build :junior_story, other: 'So are the free food and drinks'
          expect(junior_story.other_sentence).to eq 'Additional information: So are the free food and drinks.'
          junior_story.other = ''
          junior_story.publishing_consent = false
          expect(junior_story.other_sentence).to be_nil
        end
      end
    end
  end
end
