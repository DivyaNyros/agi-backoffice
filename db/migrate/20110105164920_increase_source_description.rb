class IncreaseSourceDescription < ActiveRecord::Migration
  def self.up
    change_column :sources, :description, :string, :limit => 512
  end

  def self.down
    change_column :sources, :description, :string, :limit => 100
  end
end
