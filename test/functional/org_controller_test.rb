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
class OrgControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  include OrgHelper
  include AdminHelper
  def setup
  	@org = OrgController.new
  	@req = ActionController::TestRequest.new
  	@res = ActionController::TestRequest.new
    @org.add_user_to_org(100002,100,true)
    @org.add_user_to_org(100002,101,true)
    @org.add_user_to_org(100001,100,false)
    @org.add_user_to_org(100001,101,false)
    @org.add_user_to_org(100003,101,false)
  end  
  def test_register_without_user_info
  	post :register, :org=>{:name=>'citi',:email=>'limin@citi.com',:phone=>'333333333',:country=>'USA',:city=>'New York City'}
  	assert_redirected_to login_path()
  end
  def test_register_with_valid_user_valid_org
  	session[:user_id] = 100002
  	post :register, :org=>{:name=>'citi',:email=>'limin@citi.com',:phone=>'333333333',:country=>'USA',:city=>'New York City'}
  	assert_equal 'citi',session[:org].name
    assert session[:org].users.any?
  	assert_redirected_to org_info_path
  	
  end
  def test_register_with_invalid_user_valid_org
    session[:user_id] = 123
    post :register, :org=>{:name=>'citi',:email=>'limin@citi.com',:phone=>'333333333',:country=>'USA',:city=>'New York City'}
    #assert_equal 'citi',session[:org].name    
    assert_redirected_to register_path
    
  end
  def test_add_user_to_org_with_valid_user
    result = @org.add_user_to_org(100002,100,true)
    assert_equal result,OrgHelper::ADDUSERTOORGSUCCESS
  end
  def test_add_user_to_org_with_invalid_user
    result = @org.add_user_to_org(123,100 ,true)
    assert_equal result, OrgHelper::ADDUSERTOORGFAILED
  end
  def test_list_org_users_with_valid_org_id  
    session[:user_id] = 100002
    #result = @org.list_org_users(100)
    get :list_org_users, :org_id=>100
    assert_response :success
    assert_not_nil assigns(:users)
    assert_equal assigns(:users).length, 2

    get :list_org_users, :org_id=>101
    assert_not_nil assigns(:users)
    assert_equal assigns(:users).length, 3

    session[:user_id]=100001
    get :list_org_users, :org_id=>101
    assert_equal flash[:warning],'limin is not authorized to see Goldman Sachs users'
  end
  def test_list_org_users_with_invalid_org_id
    session[:user_id] = 100002
    get :list_org_users, :org_id=>123
    assert_equal flash[:warning], 'org_id 123 is not valid'
  end
end
