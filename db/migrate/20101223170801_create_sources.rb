class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.string :name, :null => false, :limit => 50
      t.string :description, :limit => 100
      t.timestamps
      t.datetime :deleted_at
    end
  end

  def self.down
    drop_table :sources
  end
end
