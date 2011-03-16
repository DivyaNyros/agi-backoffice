class CreateAffiliates < ActiveRecord::Migration
  def self.up
    # extend the users table
    add_column :users, :type, :string, :limit => 32, :null => false, :default => 'User'
    add_column :users, :parent_id, :integer
    
    add_index :users, :type,      :name => "idx_users_by_type"
    add_index :users, :parent_id, :name => "idx_users_by_parent"
  end

  def self.down
    remove_column :users, :parent_id
    remove_column :users, :type
  end
end
