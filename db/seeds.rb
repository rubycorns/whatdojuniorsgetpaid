junior_stories = [
  {
    job: 'junior developer',
    gender: 'female',
    person_of_colour: false,
    age: 30,
    city: 'Berlin',
    country: 'DE',
    education: 'self taught',
    freelancer: false,
    first_job: 'no',
    technology: 'RoR',
    focus: 'backend',
    years_working_at_job: 'less than 1 year',
    years_working_total: 'less than 1 year',
    days_per_week: '5',
    remote: 'no',
    company_size: 'less than 10 people',
    tech_team_size: '5 - 10 people',
    company_age: 5,
    salary: 15000,
    currency: '€',
    happy_in_job: 'yes',
    happy_info: '',
    other: 'Thanks'
  },
  {
    job: 'intern',
    gender: 'male',
    person_of_colour: true,
    age: 40,
    city: 'New York',
    country: 'USA',
    education: 'bootcamp',
    freelancer: false,
    first_job: 'yes',
    technology: 'Javascript',
    focus: 'fullstack',
    years_working_at_job: '1 - 2 years',
    years_working_total: '1 - 2 years',
    days_per_week: '3',
    remote: 'yes',
    company_size: 'less than 10 people',
    tech_team_size: '5 - 10 people',
    company_age: 5,
    salary: 10000,
    currency: '$',
    happy_in_job: 'no',
    happy_info: 'I am lonely.',
    other: ''
  }
]

junior_stories.each do |js|
  JuniorStory.create!(js)
end
