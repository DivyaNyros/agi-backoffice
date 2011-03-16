class AddFieldCountryIdToAddresses < ActiveRecord::Migration
   def self.up
    add_column :addresses, :country_id, :string, :limit => 8192
  end

  def self.down
    remove_column :addresses, :country_id
  end
end
