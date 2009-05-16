class RunPublisher < Facebooker::Rails::Publisher
  def self.new_run_template_id
    Facebooker::Rails::Publisher::FacebookTemplate.find_by_template_name('RunPublisher::new_run').bundle_id
  end

  def new_run_template
    one_line_story_template "{*actor*} went for a {*distance*} run at {*location*}."
  end

end
