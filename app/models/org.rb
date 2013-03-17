#table schema:
#id :int
#name :string
#city :string
#country :string
#email :string
#entry_date :date
#last_update :date
#note :text
#phone :string

class Org < ActiveRecord::Base
	include OrgHelper
  #attr_accessible :city, :country, :email, :entry_date, :last_update, :name, :note, :phone
  #has_and_belongs_to_many :users
  has_many :admins
  has_many :users, :through=>:admins
  attr_accessible :city, :country, :email, :entry_date, :last_update, :name,:note,:phone
  validates_length_of :name,:within=>3..40
  validates_format_of :email, :with=>/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i, :message => "Invalid email"
  validates_uniqueness_of :email, :name
  validates_presence_of :city,:country,:email,:name,:phone

  def self.find_org(args)
  	o = find(:first,:conditions=>['name=?',args[:name]]) if args[:name]
  	o = find(:first,:conditions=>['email=?',args[:email]]) if args[:email]
    o = find(:first,:conditions=>['id=?',args[:id]]) if args[:id]
  	if o.nil?
  		return OrgHelper::ORGNOTEXISTED
  	else
  		return o
  	end
  end
end
