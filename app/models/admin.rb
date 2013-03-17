class Admin < ActiveRecord::Base
	include AdminHelper
	attr_accessible :user_id, :org_id,:admin
	belongs_to :org
	belongs_to :user
	def user_is_admin_for_org(user_id,org_id)
		a = Admin.find(:first,:conditions=>['user_id=? and org_id=?',user_id,org_id])
		if a.nil?
			return AdminHelper::ADMINNOTEXISTED
		else
			return a.admin
		end
	end
	def users_for_org(org_id)
		users = Admin.find(:all,:conditions=>['org_id=?',org_id])
		return users
	end
	def add_user_to_org(user_id,org_id,is_admin)
		
	end
end