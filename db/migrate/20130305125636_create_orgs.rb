class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :phone
      t.string :email
      t.date :entry_date
      t.date :last_update
      t.text :note

      t.timestamps
    end
  end
end
