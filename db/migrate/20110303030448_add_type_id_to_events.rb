class AddTypeIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :type_id, :integer
  end

  def self.down
    remove_column :events, :type_id
  end
end
