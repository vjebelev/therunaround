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

  def facebook_publish_feed_story(params)
    data = { 'distance' => params[:miles], 'location' => params[:route] }.to_json
    "facebook_publish_feed_story(#{RunPublisher.new_run_template_id}, #{data});"
  end
end
