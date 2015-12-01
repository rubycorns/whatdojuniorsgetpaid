class ChangeFreelancerToString < ActiveRecord::Migration
  def change
    change_column :junior_stories, :freelancer, :string, default: nil
  end
end
