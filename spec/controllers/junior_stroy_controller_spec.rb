require 'rails_helper'

describe JuniorStoriesController do
  describe 'GET index' do
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
end
