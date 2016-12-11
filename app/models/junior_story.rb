require 'csv'

class JuniorStory < ApplicationRecord
  include Filterable

  validates :salary, presence: true
  validates :currency, presence: true
  validates :freelancer, presence: true

  before_save :sanitize_city, :sanitize_gender

  CONSENT_ATTRIBUTES = %w(happy_in_job happy_info other)

  def job_sentence
    "I am working as a #{job}." if job.present?
  end

  def gender_sentence
    "I identify as #{gender}." if gender.present?
  end

  def person_of_colour_sentence
    "I am a person of colour." if person_of_colour?
  end

  def person_with_disability_sentence
    "I am a person with a disability." if person_with_disability?
  end

  def age_sentence
    "I am #{age} years old." if age.present?
  end

  def city_sentence
    "I live in the city of #{city}." if city.present?
  end

  def country_sentence
    "I live in the country of #{country}." if country.present?
  end

  def education_sentence
    "My educational field when it comes to programming is #{education}." if education.present?
  end

  def freelancer_sentence
    if freelancer == 'yes'
      "I am a freelancer."
    else
      "I am not a freelancer."
    end
  end

  def first_job_sentence
    if first_job.present?
      if first_job == 'yes'
        "This is my first junior/intern job."
      else
        "This is not my first junior/intern job."
      end
    end
  end

  def technology_sentence
    "My primary technology at work is #{technology}." if technology.present?
  end

  def focus_sentence
    "I am a #{focus} developer." if focus.present?
  end

  def years_working_at_job_sentence
    "I have been working at my current job for #{years_working_at_job}." if years_working_at_job.present?
  end

  def years_working_total_sentence
    "I have been working in the industry for #{years_working_total}." if years_working_total.present?
  end

  def full_time_sentence
    "I work #{days_per_week} days per week." if days_per_week.present?
  end

  def remote_sentence
    if remote.present?
      if remote == 'yes'
        "I work remotely."
      else
        "I do not work remotely."
      end
    end
  end

  def company_size_sentence
    "My company consists of #{company_size}." if company_size.present?
  end

  def tech_team_size_sentence
    "My tech team consists of #{tech_team_size}." if tech_team_size.present?
  end

  def company_age_sentence
    "My company is #{company_age} years old." if company_age.present?
  end

  def salary_sentence
    "My salary is #{salary} #{currency} per year before taxes."
  end

  def can_publish?
    publishing_consent?
  end

  def happy_in_job_sentence
    "On a scale of 1 - 5, my happiness level in my job is a #{happy_in_job}." if can_publish? && happy_in_job.present?
  end

  def happy_info_sentence
    "Additional information when it comes to my happiness: #{happy_info}." if can_publish? && happy_info.present?
  end

  def other_sentence
    "Additional information: #{other}" if can_publish? && other.present?
  end

  def publishable_attributes
    values = attributes
    unless can_publish?
      CONSENT_ATTRIBUTES.each do |attribute|
        values[attribute] = ''
      end
    end
    values
  end

  def self.to_csv(options = {})
    column_names = attribute_names.delete_if { |i| ['id', 'created_at', 'updated_at', 'publishing_consent'].include?(i) }

    CSV.generate(options) do |csv|
      csv << column_names
      find_each do |story|
        csv << story.publishable_attributes.values_at(*column_names)
      end
    end
  end

  private

  def sanitize_city
    self.city = city.strip.capitalize if city.present?
  end

  def sanitize_gender
    self.gender = gender.strip.downcase if gender.present?
  end
end
