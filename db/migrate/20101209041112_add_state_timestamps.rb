class AddStateTimestamps < ActiveRecord::Migration
  def self.up
    # EventRegistration
    add_column :event_registrations, :confirmed_at, :datetime
    add_column :event_registrations, :canceled_at, :datetime
    add_column :event_registrations, :checked_in_at, :datetime
    
    # Attendee
    add_column :attendees, :attended_at, :datetime
    add_column :attendees, :purchased_at, :datetime
  end

  def self.down
    remove_column :event_registrations, :confirmed_at
    remove_column :event_registrations, :canceled_at
    remove_column :event_registrations, :checked_in_at
    remove_column :attendees, :attended_at
    remove_column :attendees, :purchased_at
  end
end
