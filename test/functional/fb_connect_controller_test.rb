require File.dirname(__FILE__) + '/../test_helper'
require 'active_support'
require 'mocha'

class FbConnectControllerTest < ActionController::TestCase

  fixtures :all

  def setup
    @facebook_session = Facebooker::Session.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])   
  end

  def test_authenticate
    post :authenticate
    assert_not_nil @facebook_session
    assert_redirected_to @facebook_session.login_url
  end

  def test_connect_should_redirect_to_main_page
    @controller = FbConnectController.new
    assert_not_nil @facebook_session
    user = users(:first)
    user.update_attribute(:fb_uid, 123)
    @facebook_session.secure_with!("a session key", user.fb_uid, Time.now.to_i + 60)
    @request = ActionController::TestRequest.new    

    assert_not_nil @request

    @request.session[:user_id] = user.id
    @request.session[:facebook_session] = @facebook_session

    assert_not_nil @request.session[:facebook_session]
    assert_equal user.fb_uid, @request.session[:facebook_session].user.uid

    setup_controller_request_and_response
    @controller.send(:instance_variable_set, '@facebook_session', @facebook_session)
    post :connect

    assert_response :redirect
    assert_redirected_to '/'
  end
end
