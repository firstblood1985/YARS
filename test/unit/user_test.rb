require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  self.use_instantiated_fixtures=true
  fixtures :users 

 def test_user_count
 	assert_equal 3,User.count
 end
 def test_invalid_username
 	u = User.new
 	u.email='limin4@ms.com'
 	u.password=u.password_confirmation='abc'
 	u.salt='test'
 	assert u.invalid?
 	assert u.errors[:username].any?

 	u.username = '1'
 	assert u.invalid?
 	assert u.errors[:username].any?

 	u.username = 'limin'
 	assert u.invalid?
 	assert u.errors[:username].any?

 	u.username='limin4'
 	#assert !u.errors[:username].any?
 	assert u.valid?
 	assert u.errors.empty?
 end
 def test_invalid_email
 	u = User.new
 	u.username = 'limin4'
 	u.password = u.password_confirmation = 'abc'
 	u.salt='test'
 	assert u.invalid?
 	assert u.errors[:email].any?

 	u.email='123456'
 	assert u.invalid?
 	assert u.errors[:email].any?

 	u.email='limin4@ms.com'
 	#assert u.errors.empty?
 	assert u.valid?

 end
 def test_invalid_password
 	u = User.new
 	u.username = "limin4"
 end
end
