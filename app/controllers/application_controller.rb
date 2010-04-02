class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  helper_method :current_user, :facebook_user
  
  rescue_from  Facebooker::Session::SessionExpired do
    clear_facebook_session_information
    clear_fb_cookies!    
    reset_session
    redirect_to root_url
  end
  
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
  
  def current_user
    @current_user
  end

  def facebook_session
    session[:facebook_session]
  end

  def facebook_user
    (session[:facebook_session] && session[:facebook_session].session_key) ? session[:facebook_session].user : nil
  end   
  
  def login_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    session[:user_id] = nil
    session[:facebook_session] = nil
  end
  
end
