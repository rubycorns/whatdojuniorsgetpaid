FactoryGirl.define do
  factory :junior_story do
    salary 20000
    currency '$ (US)'
    publishing_consent true
    freelancer 'no'
    happy_info 'I am happy.'

    trait :without_publishing_consent do
      publishing_consent false
    end

    factory :junior_story_without_publishing_consent, traits: [:without_publishing_consent]
  end
end
