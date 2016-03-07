class JuniorStoriesController < ApplicationController

  def index
    @junior_stories = JuniorStory.
      filter(params.except(:controller, :action, :format))

    @fields = JuniorStory.attribute_names - ['id',
                                             'publishing_consent',
                                             'updated_at',
                                             'created_at']

    respond_to do |format|
      format.html
      format.csv { send_data @junior_stories.to_csv, type: 'application/csv' }
    end
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
      :gender, :city, :country, :days_per_week, :salary, :currency, :technology, :focus,
      :age, :years_working_in_total, :years_working_at_job, :education, :first_job,
      :remote, :tech_team_size, :company_size, :company_age, :person_of_colour, :other,
      :publishing_consent, :freelancer)
  end
end
