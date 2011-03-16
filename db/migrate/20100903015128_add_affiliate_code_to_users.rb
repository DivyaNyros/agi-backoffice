class AddAffiliateCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :affiliate_code, :string
  end

  def self.down
    remove_column :users, :affiliate_code
  end
end
