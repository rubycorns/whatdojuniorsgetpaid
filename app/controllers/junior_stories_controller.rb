class JuniorStoriesController < ApplicationController

  def index
    @junior_stories = JuniorStory.can_publish
  end

  def new
    @junior_story = JuniorStory.new
  end

  def show
  end

  def create
    @junior_story = JuniorStory.new(junior_story_params)
    if @junior_story.save
      redirect_to junior_stories_path
    else
      render action: 'new'
    end
  end

  private
  def junior_story_params
    params.require(:junior_story).permit(:job, :happy_in_job, :happy_info,
      :gender, :city, :country, :full_time, :salary, :currency, :technology, :focus,
      :age, :years_working_in_total, :years_working_at_job, :education, :first_job,
      :remote, :tech_team_size, :company_size, :company_age, :person_of_colour, :other,
      :publishing_consent)
  end
end
