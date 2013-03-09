class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	sign_in user
  	school = user.school_id
  	redirect_back_or school_user_path(school, user)
    else
      flash.now[:error] = 'That was not a valid email/password combination'
      render 'new' 
  end
end

  def destroy
  	sign_out
  	redirect_to root_url
  end

end
