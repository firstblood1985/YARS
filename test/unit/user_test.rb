require 'test_helper'

#error code
#LOGINSUCCESSFUL = 0
#USERNOTEXISTED = 1
#PASSWORDWRONG = 2

class UserTest < ActiveSupport::TestCase
include UserHelper
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
 	u.salt='test		'
 	assert u.invalid?
 	assert u.errors[:username].any?
#test for username too short
 	u.username = '1'
 	assert u.invalid?
 	assert u.errors[:username].any?

#test for existing username
 	u.username = 'limin'
 	assert u.invalid?
 	assert u.errors[:username].any?
#test for valid username
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
 	#test for empty email
 	assert u.invalid?
 	assert u.errors[:email].any?
 	#test for invalid email address
 	u.email='123456'
 	assert u.invalid?
 	assert u.errors[:email].any?
 	#test for valid username
 	u.email='limin4@ms.com'
 	#assert u.errors.empty?
 	assert u.valid?

 end
 def test_invalid_password
 	u = User.new
 	u.username = "limin4"
 	u.email = "limin4@ms.com"
 	u.salt = 'test'
 	# test for empty password
 	assert u.invalid?
 	assert u.errors[:password].any?

 	#test for password too short
 	u.password = '1'
 	assert u.invalid?
 	assert u.errors[:password].any?
 	#test for password not equal to password_confirmation
 	u.password = 'abc'
 	u.password_confirmation = '123'
 	assert u.invalid?
 	assert u.errors[:password].any?

 	#test for valid password
 	u.password = u.password_confirmation = 'test'
 	assert u.valid?
 end

 def test_invalid_salt
 	u=User.new
 	u.username = 'limin4'
 	u.email = 'limin4@ms.com'
 	u.password = u.password_confirmation='test'
 	assert u.invalid?
 	assert u.errors[:salt].any?
 end
 def test_authenticate
 	u = User.find(:first,:conditions=>['username=?','limin'])

 	assert_equal UserHelper::USERNOTEXISTED,User.authenticate('limin4','password')
 	assert_equal UserHelper::PASSWORDWRONG, User.authenticate('limin','abc')
 	u2 = User.authenticate('limin','test')
 	assert_equal u.username, u2.username

 end	
end
