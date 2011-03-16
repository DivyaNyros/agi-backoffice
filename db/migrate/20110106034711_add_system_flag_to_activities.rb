class AddSystemFlagToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :system, :boolean, :default => false
  end

  def self.down
    remove_column :activities, :system
  end
end
