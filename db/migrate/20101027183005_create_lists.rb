class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name
      t.integer :number
      t.string :state
      t.string :group_name
      t.string :suffix_params, :limit => 500

      t.timestamps
    end
    
    List.create :name => "WMNS", :number => 17343, :state => "no_showed", :group_name => "WM", :suffix_params => "listid=__multi&lists=17342%3A17343%3A18085%3A19082%3A19084&specialid%3A17342=31SC&specialid%3A17343=73ZX&specialid%3A18085=S2DP&specialid%3A19082=7MU4&specialid%3A19084=BYKE&clientid=714906&formid=1890&reallistid=1&doubleopt=0"
    List.create :name => "WMSUBDNB", :number => 17342, :state => "attended", :group_name => "WM", :suffix_params => "listid=__multi&lists=17342%3A17343%3A18085%3A19082%3A19084&specialid%3A17342=31SC&specialid%3A17343=73ZX&specialid%3A18085=S2DP&specialid%3A19082=7MU4&specialid%3A19084=BYKE&clientid=714906&formid=1890&reallistid=1&doubleopt=0"
    List.create :name => "WMOTF", :number => 18085, :state => "undecided", :group_name => "WM", :suffix_params => "listid=__multi&lists=17342%3A17343%3A18085%3A19082%3A19084&specialid%3A17342=31SC&specialid%3A17343=73ZX&specialid%3A18085=S2DP&specialid%3A19082=7MU4&specialid%3A19084=BYKE&clientid=714906&formid=1890&reallistid=1&doubleopt=0"
    List.create :name => "3DSUBDNB", :number => 19082, :state => "attendeed", :group_name => "3D", :suffix_params => "listid=__multi&lists=17342%3A17343%3A18085%3A19082%3A19084&specialid%3A17342=31SC&specialid%3A17343=73ZX&specialid%3A18085=S2DP&specialid%3A19082=7MU4&specialid%3A19084=BYKE&clientid=714906&formid=1890&reallistid=1&doubleopt=0"
    List.create :name => "3DOTF", :number => 19084, :state => "undecided", :group_name => "3D", :suffix_params => "listid=__multi&lists=17342%3A17343%3A18085%3A19082%3A19084&specialid%3A17342=31SC&specialid%3A17343=73ZX&specialid%3A18085=S2DP&specialid%3A19082=7MU4&specialid%3A19084=BYKE&clientid=714906&formid=1890&reallistid=1&doubleopt=0"
  end

  def self.down
    drop_table :lists
  end
end
