require 'digest/sha1'

#== schema info
# table name : users
#id				:int
#email			:string
#username		:string
#first			:string
#last 			:string
#pw 			:string
#siteadmin		:boolean
#salt 			:string
#phone			:string
#entry_date		:date
#last_login		:date
#note			:text

#error code
#LOGINSUCCESSFUL = 0
#USERNOTEXISTED = 1
#PASSWORDWRONG = 2
class User < ActiveRecord::Base
  #attr_accessible :email, :entry_date, :last_login, :note, :phone, :pw, :siteadmin, :username
  include UserHelper
  attr_accessible :email, :username,:first,:last
  attr_accessor :password, :password_confirmation
  attr_protected :id, :salt,:siteadmin
  validates_length_of :username, :within=>2..40
  validates_length_of :password, :within=>2..20
  validates_presence_of :username,:email,:password,:password_confirmation,:salt
  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_format_of :email, :with=>/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i, :message => "Invalid email"

  def self.authenticate(username, password)
  	u=find(:first,:conditions=>['username=?',username])
  	return UserHelper::USERNOTEXISTED if u.nil?
  	return u if u.pw == User.encrypt(password,u.salt)
  	return UserHelper::PASSWORDWRONG
  end
  def self.encrypt(password,salt)
  	Digest::SHA1.hexdigest(password+salt)
  end
end
