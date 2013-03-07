require 'test_helper'

class UserControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@con = UserController.new
  	@req = ActionController::TestRequest.new
  	@res = ActionController::TestRequest.new
  end
  def test_login_with_invalid_user
  	post :login, :user=>{:username=> 'limin4', :password=>'test'}
  	assert_response :success
  	assert_equal "User limin4 not existed", flash[:warning]

  	post :login, :user=>{:username=>'limin', :password=>'abc'}	
  	assert_response :success
  	assert_equal "Wrong Password", flash[:warning]
  end
  def test_login_with_valid_user
  	post :login, :user=>{:username=>'limin',:password=>'test'}
  #	assert_response :success
  	assert_equal "User limin Login successfully", flash[:notice]
  	assert_redirected_to org_path()
  end 
  def test_get_login_page
  	get :login
  	assert_equal nil,flash[:warning]
  	assert_equal nil,flash[:notice]
  end 
end
