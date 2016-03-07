class JuniorStoriesController < ApplicationController

  def index
    @junior_stories = JuniorStory.
      filter(params.except(:method, :controller, :action, :format, :utf8, :authenticity_token,))

    @fields = fields

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

  # TODO: shouldn't hard code this, but I like having demo search terms in the list
  def fields
    {
      job: "junior developer",
      happy_in_job: "yes",
      happy_info: "It's ok",
      gender: "female",
      city: "Berlin",
      country: "DE",
      days_per_week: "5",
      salary: "15000",
      currency: "€",
      technology: "RoR",
      focus: "backend",
      age: 30,
      years_working_total: "less than 1 year",
      years_working_at_job: "less than 1 year",
      education: "self taught",
      first_job: "no",
      remote: "no",
      tech_team_size: "5 - 10 people",
      company_size: "less than 10 people",
      company_age: 5,
      person_of_colour: false,
      other: "Thanks",
      freelancer: "f"
    }
  end
end
