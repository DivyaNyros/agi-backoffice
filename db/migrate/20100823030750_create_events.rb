class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name, :null => false
      t.string :description, :instructions, :limit => 2048
      t.string :location, :limit => 1024
      t.date :start_date, :end_date, :null => false
      t.time :start_time, :end_time, :null => false      
      t.timestamps
      t.datetime :deleted_at
      t.integer :lock_version, :default => 0, :null => false
    end
    
    add_index :events, [:start_date, :start_time, :end_date, :end_time], :name => "idx_events_by_chronos"
  end

  def self.down
    drop_table :events
  end
end
