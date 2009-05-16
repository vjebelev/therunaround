class LoginController < ApplicationController
  def register
    if request.post?
      user = User.new(params[:user])

      # joining via FB connect: link to FB account and set a random password
      if params[:fb_user]
        user.fb_uid = facebook_user.uid
        user.password = Time.now.to_f.to_s
      end

      if user.save
        login_user(user)
        redirect_to '/'
      end
    end
  end

  def login
    if request.post?
      user = User.find_by_username(params[:username])
      if user && user.password == params[:password]
        login_user(user)
        return redirect_to('/')
      end
    end

    redirect_to :back
  end

  def logout
    logout_user
    redirect_to '/'
  end
end
