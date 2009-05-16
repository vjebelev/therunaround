class WelcomeController < ApplicationController
  def index
    if request.post?
      if !params[:miles].blank?
        begin
          run = current_user.runs.new(:miles => params[:miles], :route => params[:route], :date => Date.civil(params[:date_year].to_i, params[:date_month].to_i, params[:date_day].to_i))
          if run.save
            flash[:notice] = 'Added a new run!'

            if params[:publish_to_facebook]
              respond_to do |format|
                format.js {
                  data = {
                    'distance' => params[:miles],
                    'location' => params[:route]
                  }.to_json
                  render :update do |page|
                    page << "FB.Connect.showFeedDialog(#{RunPublisher.new_run_template_id}, data, null, null, null, RequireConnect.require, null);"
                  end
                }
              end
            end
          else
            flash[:error] = 'Something went wrong while saving the run.'
          end

        rescue Exception => e
          logger.debug "Exception while adding a run: #{e.backtrace.join("\n")}"
          flash[:error] = 'Something went wrong while saving the run.'
        end

      end
    end
  end
end
