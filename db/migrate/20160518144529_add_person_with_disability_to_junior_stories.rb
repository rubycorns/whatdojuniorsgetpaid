class AddPersonWithDisabilityToJuniorStories < ActiveRecord::Migration
  def change
    add_column :junior_stories, :person_with_disability, :boolean, default: false
  end
end
