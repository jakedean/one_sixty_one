class ItemsController < ApplicationController
  
  def index 
  	@school = School.find(params[:school_id])
    @user = User.find(params[:user_id])
    @users = @school.users
  	@items = Item.where('school_id = ?', @school.id)
          
  end

  def new
    @school = School.find(params[:school_id])
    @user = User.find(params[:user_id])
    @item = @user.items.new
  end

  def show
    @item = Item.find(params[:id])
    @school = School.find(params[:school_id])
    @want = Want.new
    @vote = Vote.new
    @reactions = @item.reactions.paginate(page: params[:page])
    @reaction = Reaction.new
  end

  def create
    @school = School.find(params[:school_id])
    @user = User.find(params[:user_id])
    @users = @school.users
    @item = @user.items.build(params[:item])
    @item.school_id = @school.id
    if @item.save
    	flash[:success] = "We added it!"
    	redirect_to school_user_items_path(@school, @user)
    else
    	render 'new'
    end
  end

  #def update
   # @item = Item.find(params[:id])
    #submission_hash = {counter: @item.plus_one}
    #@item.update_attributes(submission_hash)
    #if @item.update_attributes(submission_hash)
     # flash[:success] = 'Awesome, thanks for the vote'
      #redirect_to :back
    #else
     # flash[:error] = 'You already voted for this one'
      #redirect_to :back
    #end
  #end

  def destroy
    @item.destroy
    flash[:success] = "Boom, destroyed!"
    redirect_to(items_url)
  end

  


end
