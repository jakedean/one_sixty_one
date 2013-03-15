class ItemsController < ApplicationController


  before_filter :signed_in_user
  
  def index 
  	@school = School.find(params[:school_id])
    @users = @school.users
  	@items = Item.where('school_id = ?', current_user.school_id)
          
  end

  def new
  end

  def show
    @item = Item.find(params[:id])
    
  end

  def create
    @school = School.find(current_user.school_id)
    @item = current_user.items.build(params[:item])
    if @item.save
    	flash[:success] = "We added it!"
    	redirect_to school_items_path(@school)
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
