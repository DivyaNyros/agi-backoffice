class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.string :first_name, :last_name
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :users, :email,                :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :deleted_at,           :name => "idx_deleted_users"
    
  end

  def self.down
    drop_table :users
  end
end
