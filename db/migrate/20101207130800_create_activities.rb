class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :actionable_type, :null => false
      t.integer :actionable_id, :null => false
      t.belongs_to :actor
      t.string :category, :limit => 32
      t.string :data, :limit => 4096
      t.timestamps
    end
    
    add_index :activities, [:actionable_id, :actionable_type],  :name => "idx_activities_by_actionable"
    add_index :activities, [:actor_id],                         :name => "idx_activities_by_actor"
    add_index :activities, [:category],                         :name => "idx_activities_by_category"
  end

  def self.down
    drop_table :activities
  end
end
