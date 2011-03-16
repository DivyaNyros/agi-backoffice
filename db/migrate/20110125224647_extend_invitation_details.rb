class ExtendInvitationDetails < ActiveRecord::Migration
  def self.up
    add_column :invitations, :first_name, :string
    add_column :invitations, :last_name, :string
  end

  def self.down
    remove_column :invitations, :first_name
    remove_column :invitations, :last_name
  end
end
