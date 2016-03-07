require 'rails_helper'

describe JuniorStoriesController do
  describe 'GET index' do
    context 'without filter params' do
      it 'assigns @junior_stories' do
        story = build :junior_story
        story.save
        get :index
        expect(assigns(:junior_stories)).to eq([story])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'does not render index, but instead responds with csv' do
        get :index, format: 'csv'
        expect(response).not_to render_template('index')
        expect(response.content_type).to include 'application/csv'
      end
    end

    context 'with legal filter params' do
      it 'returns only the filter appropriate junior_story' do
        female_story = build :junior_story
        female_story.gender = 'female'
        female_story.save

        male_story = build :junior_story
        male_story.gender = 'male'
        male_story.save


        get :index, { 'gender' => 'female' }
        expect(assigns(:junior_stories)).to eq([female_story])
      end

      it 'renders the index template' do
        get :index, { 'gender' => 'female' }
        get :index
        expect(response).to render_template('index')
      end

      it 'does not render index, but instead responds with csv' do
        get :index, { 'gender' => 'female', 'format' => 'csv' }
        expect(response).not_to render_template('index')
        expect(response.content_type).to include 'application/csv'
      end
    end

    context 'with illegal filter params' do
      it 'returns only the filter appropriate junior_story' do
        female_story = build :junior_story
        female_story.gender = 'female'
        female_story.save

        male_story = build :junior_story
        male_story.gender = 'male'
        male_story.save


        get :index, { 'makes_no_sense' => 'random' }
        expect(assigns(:junior_stories)).to eq([female_story, male_story])
      end

      it 'renders the index template' do
        get :index, { 'makes_no_sense' => 'random' }
        get :index
        expect(response).to render_template('index')
      end

      it 'does not render index, but instead responds with csv' do
        get :index, { 'makes_no_sense' => 'random', 'format' => 'csv' }
        expect(response).not_to render_template('index')
        expect(response.content_type).to include 'application/csv'
      end
    end
  end
end
