require 'test_helper'
#== schema info
# table name : users
#id       :int
#email      :string
#username   :string
#first      :string
#last       :string
#pw       :string
#siteadmin    :boolean
#salt       :string
#phone      :string
#entry_date   :date
#last_login   :date
#note     :text

class UserControllerTest < ActionController::TestCase
  include UserHelper
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
  	assert_redirected_to org_info_path()
  end 
  def test_get_login_page
  	get :login
  	assert_equal nil,flash[:warning]
  	assert_equal nil,flash[:notice]
  end 
  def test_get_register_page
    get :register
    assert_equal nil, flash[:warning]
    assert_equal nil, flash[:notice]
  end
  def test_register_valid_user
    post :register, :user=>{:username=>'limin4',:password=>'test',:password_confirmation=>'test',:email=>'limin4@ms.com',:first=>'Min',:last=>'Li',:phone=>'18621717879'}
    assert_equal "Register Success", flash[:notice]
    assert_equal 100004,session[:user_id]
  # assert_equal 'Register Failed', flash[:warning]
  end
  def test_register_invalid_user
    post :register, :user=>{:username=>'limin',:password=>'test',:password_confirmation=>'test',:email=>'limin@ms.com',:first=>'Min',:last=>'Li',:phone=>'18621717879'}
    assert_response :success
    assert_equal 'Register Failed',flash[:warning]

    post :register, :user=>{:username=>'limin4',:password=>'test',:password_confirmation=>'test',:email=>'limin@ms.com',:first=>'Min',:last=>'Li',:phone=>'18621717879'}
    assert_response :success
    assert_equal 'Register Failed',flash[:warning]
  end
  def test_find_user_by_valid_id
    u = UserController.find_user_by_id(100001)
    assert_equal u.username, 'limin'
  end
  def test_find_user_by_invalid_id
    u = UserController.find_user_by_id(123)
    assert_equal u, UserHelper::USERNOTEXISTED
  end
end
