class AddSourceIdToEventRegistration < ActiveRecord::Migration
  def self.up
    add_column :event_registrations, :source_id, :integer
  end

  def self.down
    remove_column :event_registrations, :source_id
  end
end
