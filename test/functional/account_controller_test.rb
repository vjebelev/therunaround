require File.dirname(__FILE__) + '/../test_helper'

class AccountControllerTest < ActionController::TestCase 
  fixtures :all
  
  def setup
    @user = users(:first)
    session[:user_id] = @user.id    
  end
  
  def test_account_settings_get
    get :settings
    assert_response :success
  end
  
  def test_account_settings_update
    @user.name = "Another User"
    @user.email = "email@name.me"
    
    post :settings, :current_user => {:name => @user.name, :email => @user.email}
    assert_response :success
    
    assert_not_nil User.find_by_name("Another User")
    assert_not_nil User.find_by_email("email@name.me")
  end
end