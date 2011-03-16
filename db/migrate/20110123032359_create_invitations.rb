class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :code, :limit => 15, :null => false
      t.string :email, :limit => 256, :null => false
      t.belongs_to :affiliate, :null => true
      t.boolean :accepted, :default => false, :null => false
      t.timestamps
      t.datetime :expires_at
    end
    
    add_index :invitations, :code, :unique => true, :name => "idx_invitations_by_code"
    add_index :invitations, :email, :name => "idx_invitations_by_email"
  end

  def self.down
    drop_table :invitations
  end
end
