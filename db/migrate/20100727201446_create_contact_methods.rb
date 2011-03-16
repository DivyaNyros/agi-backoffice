class CreateContactMethods < ActiveRecord::Migration
  def self.up
    create_table :contact_methods do |t|
      t.string :contactable_type, :null => false
      t.integer :contactable_id, :null => false
      t.string :type, :null => false, :limit => 64
      t.string :data, :limit => 512
      t.string :category, :limit => 32
      t.timestamps
    end
    
    add_index :contact_methods, [:contactable_type, :contactable_id], :name => "idx_contact_methods_by_contactable"
  end

  def self.down
    drop_table :contact_methods
  end
end
