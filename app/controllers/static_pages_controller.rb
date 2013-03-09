class StaticPagesController < ApplicationController

  def home
  	if signed_in?
  	  @school = School.find(current_user.school_id)
  	  render 'home'
    else
  	  render 'home'
  end
end

  def about
  	if signed_in?
  	  @school = School.find(current_user.school_id)
  	  render 'about'
  
    else
    	render 'about'
  end
end
  
end
