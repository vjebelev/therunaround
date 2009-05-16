class AccountController < ApplicationController
  def settings
    if request.post?
      if current_user.update_attributes(params[:current_user])
        flash[:notice] = 'Settings have been updated'
      end
    end
  end

end
