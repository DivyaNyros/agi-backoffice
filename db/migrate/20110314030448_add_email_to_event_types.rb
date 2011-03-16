class AddEmailToEventTypes < ActiveRecord::Migration
  def self.up
    add_column :event_types, :email, :string
  end

  def self.down
    remove_column :event_types, :email
  end
end
