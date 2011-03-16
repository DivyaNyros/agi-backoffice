class AddPrivateToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :private, :boolean, :default => true
  end

  def self.down
    remove_column :events, :private
  end
end
