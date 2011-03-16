class CreateEventRegistrations < ActiveRecord::Migration
  def self.up
    create_table :event_registrations do |t|
      t.belongs_to :attendee, :null => false
      t.belongs_to :event, :null => false
      t.string :state, :limit => 32, :default => 'registered', :null => false
      t.timestamps
    end
    
    add_index :event_registrations, [:attendee_id, :event_id], :name => "idx_event_registrations", :unique => true
    add_index :event_registrations, :state, :name => "idx_event_registrations_by_state"
  end

  def self.down
    drop_table :event_registrations
  end
end
