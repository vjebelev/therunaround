# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    @current_user
  end

  def facebook_session
    session[:facebook_session]
  end

  def facebook_user
    (session[:facebook_session] && session[:facebook_session].session_key) ? session[:facebook_session].user : nil
  end
end
