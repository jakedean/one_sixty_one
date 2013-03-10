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
    @school = School.find(params[:school_id])
    @wants = @user.wants
  end

  def create
  	@school = School.find(params[:school_id])
  	@user = @school.users.new(params[:user])
  	if @user.save
  	  sign_in @user
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

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users
    @school = School.find(params[:school_id])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    @school = School.find(params[:school_id])
    render 'show_follow'
  end

  def personal_item
    @title = "My Items"
    @user = User.find(params[:id])
    @school = School.find(params[:school_id])
    @want = Want.find(params[:format])
    @personal_item = Item.find(@want.item_id)
  end

end
