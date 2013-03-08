class ItemsController < ApplicationController
  
  def index 
  	@school = School.find(params[:school_id])
  	@items = @school.items.paginate(page: params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @reactions = @item.reactions.paginate(page: params[:page])
  end

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
    	flash[:success] = "We added it!"
    	redirect_to(items_url)
    else
    	render 'index'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "Boom, destroyed!"
    redirect_to(items_url)
  end

end
