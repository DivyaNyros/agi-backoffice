class AddStateToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :state, :string, :limit => 32, :null => false, :default => 'unpublished'
    add_index :events, :state, :name => "idx_events_by_state"
  end

  def self.down
    remove_index :events, :name => :idx_events_by_state
    remove_column :events, :state
  end
end
