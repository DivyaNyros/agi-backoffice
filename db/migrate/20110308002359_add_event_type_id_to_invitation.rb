class AddEventTypeIdToInvitation < ActiveRecord::Migration
  def self.up
    add_column :invitations, :event_type_id, :integer
  end

  def self.down
    remove_column :invitations, :event_type_id
  end
end
