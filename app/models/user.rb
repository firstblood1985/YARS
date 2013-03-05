class User < ActiveRecord::Base
  attr_accessible :email, :entry_date, :last_login, :note, :phone, :pw, :siteadmin, :username
end
