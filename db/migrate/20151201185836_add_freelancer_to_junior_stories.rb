class AddFreelancerToJuniorStories < ActiveRecord::Migration
  def change
    add_column :junior_stories, :freelancer, :boolean, default: false
  end
end
