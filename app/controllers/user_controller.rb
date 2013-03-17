#   error code:
#	USERNOTEXISTED = 1
#	PASSWORDWRONG = 2

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
class UserController < ApplicationController
	include UserHelper
	include ApplicationHelper
	def welcome
	end
	def login
		if request.post?
			username,password = params[:user][:username], params[:user][:password]
			logger.debug username
			logger.debug password
			case session[:user] = User.authenticate(username,password)
			when UserHelper::USERNOTEXISTED
				flash[:warning] = "User #{username} not existed"
			when UserHelper::PASSWORDWRONG
				flash[:warning] = "Wrong Password"
			else
			#successfully log in
			flash[:notice] = "User #{username} Login successfully"
			redirect_to org_info_path()
		end
		else
			clear_flash
		end
	end
	def register
		if request.post?
			#params[:user][:password]=params[:user][:password_confirmation] = UserHelper::DEFAULTPASSWORD
			@user = User.new(params[:user])
			@user.password_confirmation = params[:user][:password_confirmation]
			@user.password = params[:user][:password]
			if @user.save
				flash[:notice] = "Register Success"
				session[:user_id] = User.authenticate(@user.username,@user.password).id
				redirect_to :action=>"welcome"
			else
				flash[:warning]= "Register Failed"
			end
		else
			clear_flash
		end
	end
	def self.find_user_by_id(user_id)
		u = User.find_user_by('id',user_id)
		if u == UserHelper::USERNOTEXISTED
			return UserHelper::USERNOTEXISTED
		else
			return u
		end
	end
end
