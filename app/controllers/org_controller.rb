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
class OrgController < ApplicationController
	include ApplicationHelper
	include OrgHelper
	include UserHelper
	#include AdminHelper
	def register
		user_con = UserController.new
		if request.post?
			#check if session[:user] has value, otherwise, log in first
			if session[:user_id]
				user_id = session[:user_id]
				u = UserController.find_user_by_id(user_id)

				if u == UserHelper::USERNOTEXISTED
					redirect_to register_path()
				end

				@org = Org.new(params[:org])
				if @org.save
					flash[:notice] = "#{@org.name} register success"
					#@org = Org.find(:first,:conditions=>['name=?',params[:org][:name]])
					org_id = Org.find_org(:name=>@org.name).id
					if @org != OrgHelper::ORGNOTEXISTED
						result = add_user_to_org(user_id,org_id,true)
						if result == OrgHelper::ADDUSERTOORGSUCCESS
							session[:org] = @org
							redirect_to org_info_path()
						end
					end
				else
					flash[:warning] = '#{@org.name} register failed'
				end
			else
				redirect_to login_path()
			end
		else
			clear_flash
		end
	end
	####target on 3/11
	def add_user_to_org(user_id,org_id,is_admin)
		u = UserController.find_user_by_id(user_id)
		org = Org.find_org(:id=>org_id)
		#puts org
		if u==UserHelper::USERNOTEXISTED || org ==OrgHelper::ORGNOTEXISTED
			return OrgHelper::ADDUSERTOORGFAILED
		else
			org.admins.create(:user_id=>u.id,:org_id=>org.id,:admin=>is_admin)
			return OrgHelper::ADDUSERTOORGSUCCESS
		end
	end
	def list_org_users()
		org_id = params[:org_id]
		#puts org_id
		user_id = session[:user_id]
		u = UserController.find_user_by_id(user_id)

		org = Org.find_org(:id=>org_id)
		if org ==OrgHelper::ORGNOTEXISTED
			flash[:warning] = "org_id #{org_id} is not valid"
		else
			#is_admin = org.admins.user_is_admin_for_org(user_id,org_id)
			admin = Admin.new()
			is_admin = admin.user_is_admin_for_org(user_id,org_id)
			if is_admin != AdminHelper::ADMINNOTEXISTED && is_admin
				@users = admin.users_for_org(org_id)	
					#puts @users
			else
				flash[:warning] = "#{u.username} is not authorized to see #{org.name} users"
			end
		end

	end
end
