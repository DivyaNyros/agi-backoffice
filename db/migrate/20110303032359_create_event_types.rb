class CreateEventTypes < ActiveRecord::Migration
  def self.up
    create_table :event_types do |t|
      t.string :name, :limit => 15, :null => false
      t.string :description, :limit => 256
      t.timestamps
    end
  end

  def self.down
    drop_table :event_types
  end
end
