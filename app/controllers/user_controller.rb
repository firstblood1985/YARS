#   error code:
#	USERNOTEXISTED = 1
#	PASSWORDWRONG = 2
class UserController < ApplicationController
	include UserHelper
	include ApplicationHelper
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
			redirect_to org_path()
		end
		else
			clear_flash
		end
	end
	def add
		if request.post?
			params[:user][:password]=params[:user][:password_confirmation] = UserHelper::DEFAULTPASSWORD
			
		else
		end
	end
end
