class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username
      t.string :first
      t.string :last
      t.string :pw
      t.string :salt
      t.string :email
      t.date :create_date
      t.date :last_login
      t.date :last_update

      t.timestamps
    end
  end
end
