class AdminTable < ActiveRecord::Migration
  def up
  	create_table :admins, :id=>false do |t|
  		t.integer :org_id
  		t.integer :user_id
  		t.boolean :admin
  	end
  	add_index :admins, [:org_id,:user_id]
  end

  def down
  	drop_table :admins
  end
end
