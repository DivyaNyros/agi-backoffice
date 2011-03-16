class AddGuestAndGuestOfToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :guest, :integer
    add_column :attendees, :guest_of, :integer
  end

  def self.down
    remove_column :attendees, :guest
    remove_column :attendees, :guest_of
  end
end
