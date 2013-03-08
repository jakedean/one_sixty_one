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
  	@school = School.find(params[:school_id])
  	@user = User.new(params[:user])
  	if @user.save
  	  @school.users << @user
  	  #sign_in @user
  	  flash[:success] = 'Welcome to the app!'
  	  redirect_to school_user_path(@school, @user)
    else
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
