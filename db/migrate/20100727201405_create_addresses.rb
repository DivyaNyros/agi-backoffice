class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :addressable_type, :null => false
      t.integer :addressable_id, :null => false
      t.string :street, :unit, :city, :state, :zip
      t.string :category, :limit => 32
      t.timestamps
    end
    
    add_index :addresses, [:addressable_type, :addressable_id], :name => "idx_addresses_by_addressable"
  end

  def self.down
    drop_table :addresses
  end
end
