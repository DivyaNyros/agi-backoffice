class AddIcontactGroupToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :icontact_group, :string, :limit => 50
  end

  def self.down
    remove_column :events, :icontact_group
  end
end
