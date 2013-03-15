class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers, :personal_item]
  def new
  	@school = School.find(params[:school_id])
  	@user = User.new
  end

  def index
  	@school = School.find(current_user.school_id)
    if params[:search]
      @users = @school.users.find(:all, conditions: ["name like ?", "%#{params[:search]}%"])
    else
  	  @users = @school.users.paginate(page: params[:page])
    end
  end

  def show
  	@user = User.find(params[:id])
    @school = School.find(current_user.school_id)
    @wants = @user.wants
  end

  def create
  	@school = School.find(params[:school_id])
  	@user = @school.users.build(params[:user])
  	if @user.save
  	  sign_in @user
  	  flash[:success] = 'Welcome to the app!'
  	  redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Successful Update"
      sign_in @user
  		redirect_to user_path(@user)
  	else
      flash[:error] = "That didn't work, try again please."
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
    @school = School.find(current_user.school_id)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    @school = School.find(current_user.school_id)
    render 'show_follow'
  end

  def personal_item
    @title = "My Items"
    @user = User.find(params[:id])
    @school = School.find(current_user.school_id)
    @want = Want.find(params[:format])
    @personal_item = Item.find(@want.item_id)
    @personal = Personal.new
    
  end

  def feed 
    @user = User.find(params[:id])
    @users = @user.followed_users
    @wants = @users.collect { |user| user.wants }
    @votes = @users.collect { |user| user.votes }
    @combo = [@wants, @votes].flatten
    @combo_ordered = @combo.sort_by(&:updated_at).reverse
  end

end
