class UsersController < ApplicationController

  def new
  	@school = School.new
  	@user = User.new
  end

  def index
  	@school = School.find(params[:school_id])
  	@users = @school.users.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.find(params[:user])
  	if @user.save
  	  #sign_in @user
  	  flash[:success] = 'Welcome to the app!'
  	  redirect_to school_users_path(@school)
    else
      flash[:error] = "Make sure you list the full name"
      render 'new'
    end
  end

  def edit
  	@school = School.find(params[:id])
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		sign_in @user
  		flash[:success] = "Successful Update"
  		redirect_to @user
  	else
  		render 'edit'
  end
end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:succes] = "User destroyed!"
  	render 'index'
  end

end
