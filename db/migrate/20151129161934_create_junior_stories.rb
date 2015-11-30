class CreateJuniorStories < ActiveRecord::Migration
  def change
    create_table :junior_stories do |t|

      t.string :job
      t.string :happy_in_job
      t.text :happy_info
      t.string :gender
      t.string :city
      t.string :country
      t.string :full_time
      t.string :salary
      t.string :currency
      t.string :technology
      t.string :focus
      t.integer :age
      t.string :years_working_total
      t.string :years_working_at_job
      t.string :education
      t.string :first_job
      t.string :remote
      t.string :tech_team_size
      t.string :company_size
      t.integer :company_age
      t.boolean :person_of_colour, default: false
      t.text :other
      t.boolean :publishing_consent, default: true
      t.timestamps null: false
    end
  end
end
