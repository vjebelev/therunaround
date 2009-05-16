# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper

  before_filter :load_current_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0a444edd0c90caa49933aa3924fcd3c9'

  def load_current_user
    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
    end
  end
  
  protected
  def login_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    session[:user_id] = nil
    session[:facebook_session] = nil
  end
end
