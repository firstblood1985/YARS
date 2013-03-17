require 'test_helper'
#table schema
#user_id int
#org_id int
#admin boolean
class OrgTest < ActiveSupport::TestCase
	include AdminHelper
	def setup
		@org = OrgController.new
		@org.add_user_to_org(100002,100,true)
		@org.add_user_to_org(100002,101,true)
		@org.add_user_to_org(100001,100,false)
		@org.add_user_to_org(100001,101,false)
		@org.add_user_to_org(100003,101,false)
	end

	def test_user_is_admin_for_org_with_valid_user
		admin = Admin.new
		a = admin.user_is_admin_for_org(100002,100)
		assert_equal a,true

		a = admin.user_is_admin_for_org(100001,100)
		assert_equal a,false
	end
	def test_user_is_admin_for_org_with_invalid_user
		admin = Admin.new
		a = admin.user_is_admin_for_org(100003,100)
		assert_equal a, AdminHelper::ADMINNOTEXISTED
	end
	def test_users_for_org
		org_id = 100
		admin = Admin.new
		users = admin.users_for_org(org_id)
		assert_equal users.length,2

		org_id = 101
		users = admin.users_for_org(org_id)
		assert_equal users.length,3

		org_id = 102
		users = admin.users_for_org(org_id)
		assert_equal users.length,0
	end
end
