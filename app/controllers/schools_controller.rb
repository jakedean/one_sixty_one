class SchoolsController < ApplicationController
  def new
  	@school = School.new
  end

  def create 
  	@school = School.find(params[:id])
  	if @school.save
  		flash[:success] = "Your school was added!"
  		redirect_to signin_path
  	else
  		render 'new'
  	end
  end

  def destroy
  	School.find(params[:id]).destroy
  	flash[:success] = "Your school was deleted!"
  	render 'new'
  end
  
end
