class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :siteadmin
      t.string :username
      t.string :pw
      t.string :email
      t.string :phone
      t.date :last_login
      t.date :entry_date
      t.text :note

      t.timestamps
    end
  end
end
