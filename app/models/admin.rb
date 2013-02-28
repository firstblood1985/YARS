class Admin < ActiveRecord::Base
  attr_accessible :create_date, :email, :first, :last, :last_login, :last_update, :pw, :salt, :username
end
