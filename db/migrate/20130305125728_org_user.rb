class OrgUser < ActiveRecord::Migration
  def up
  	create_table :users_orgs do |t|
  		t.references :user
  		t.references :org
  	end
  end

  def down
  	drop_table :users_orgs
  end
end
