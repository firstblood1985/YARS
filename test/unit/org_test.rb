require 'test_helper'
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

class OrgTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_invalid_name
  	o = Org.new
  	o.city = 'shanghai'
  	o.country='China'
  	o.email = 'limin@example.com'
  	o.phone='333333333'

  	#empty org name
  	assert o.invalid?
  	assert o.errors[:name].any?

  	#short org name
  	o.name='hi'
  	assert o.invalid?
  	assert o.errors[:name].any?

  	#existing name
  	o.name='Morgan Stanley'
  	assert o.invalid?
  	assert o.errors[:name].any?

  end
  def test_valid_name
  	o=Org.new
  	o.city = 'shanghai'
  	o.country='China'
  	o.email = 'limin@example.com'
  	o.phone='333333333' 

  	o.name='Citi'
  	assert o.valid?
  end
  def test_invalid_email
  	o=Org.new
  	o.city = 'shanghai'
  	o.country='China'
  	o.name = 'Citi'
  	o.phone='333333333' 

  	#empty email
  	assert o.invalid?
  	assert o.errors[:email].any?

  	o.email = '123456'
  	assert o.invalid?
  	assert o.errors[:email].any?

  	o.email = 'limin@ms.com'
  	assert o.invalid?
  	assert o.errors[:email].any?
  end
  def test_valid_email
  	o=Org.new
  	o.city = 'shanghai'
  	o.country='China'
  	o.name = 'Citi'
  	o.phone='333333333' 

  	o.email='limin@citi.com'
  	o.valid?
  end

end














































