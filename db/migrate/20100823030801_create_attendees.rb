class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :first_name, :last_name, :email, :null => false
      t.belongs_to :affiliate
      t.string :state, :limit => 32, :default => 'registered', :null => false
      t.timestamps
      t.datetime :deleted_at
      t.integer :lock_version, :default => 0, :null => false
    end
    
    add_index :attendees, :affiliate_id, :name => "idx_attendees_by_affiliate"
    add_index :attendees, [:state, :deleted_at], :name => "idx_attendees_by_state"
  end

  def self.down
    drop_table :attendees
  end
end
