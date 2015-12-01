class RenameFulltimeToDaysPerWeek < ActiveRecord::Migration
  def change
    rename_column :junior_stories, :full_time, :days_per_week
  end
end
