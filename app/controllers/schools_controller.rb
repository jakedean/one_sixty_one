class SchoolsController < ApplicationController
  def new
  	@school = School.new
  end

  def index
    @schools = School.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @schools.map(&:name)
  end

  def show
    @school = School.find(params[:id])
  end

  def create 
  	@school = School.find_or_create_by_name(params[:school][:name])
  	if @school.save
  		flash[:success] = "Your school was selected!"
  		redirect_to new_school_user_path(@school)
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
