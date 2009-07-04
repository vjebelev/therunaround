require File.dirname(__FILE__) + '/../test_helper'
require 'active_support'
require 'mocha'

class FbConnectControllerTest < ActionController::TestCase

  fixtures :all

  def setup
    ENV['FACEBOOK_API_KEY'] = '1234567'
    ENV['FACEBOOK_SECRET_KEY'] = '7654321'   
    @facebook_session = Facebooker::Session.create('test', 'test')   
  end

  def test_authenticate
    post :authenticate
    assert_not_nil @facebook_session
    assert_redirected_to @facebook_session.login_url
  end

  def test_connect
    @facebook_session = mock('Facebooker::Session')
    @facebook_session.stubs(:secured? => true)
    assert_not_nil @facebook_session
    assert @facebook_session.secured?

    @request = ActionController::TestRequest.new    
    @response = ActionController::TestResponse.new
    @controller = FbConnectController.new
    assert_not_nil @request
    assert_not_nil @response

    user = mock('user')
    user.stubs(:id => 1, :fb_uid => 123, :is_facebook_user? => true)

    session[:facebook_session] = mock('Facebooker::Session')
    session[:facebook_session].stubs(:session_key => 'a session key', :user => user, :secured? => true, :inspect => "Facebooker::Session #{Time.now}")
    User.expects(:find_by_fb_uid).with(123).returns(user)
    assert_equal user, User.find_by_fb_uid(123)

    assert_equal 'a session key', session[:facebook_session].session_key
    assert_equal user, session[:facebook_session].user
    assert facebook_user?

    assert session[:facebook_session].secured?

    @request.session[:user_id] = session[:user_id]
    @request.session[:facebook_session] = session[:facebook_session]

    post :connect
    assert_response :redirect
  end

  def test_connect_must_be_redirected_to_register
    @request = ActionController::TestRequest.new
    @facebook_session = Facebooker::Session.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])
    @facebook_session.secure_with!("a session key", "123456", Time.now.to_i + 60)
    assert(@facebook_session.secured?)
    assert_equal 'a session key', @facebook_session.session_key
    assert_equal 123456, @facebook_session.user.to_i
    assert_not_nil @facebook_session
    @request.session[:facebook_session] = @facebook_session
    setup_controller_request_and_response

    post :connect
    assert_response :redirect
  end

  private
  def facebook_user?
    (session[:facebook_session] && session[:facebook_session].session_key) ? true : nil
  end
end
