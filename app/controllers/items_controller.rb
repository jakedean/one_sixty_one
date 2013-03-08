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
    @items = @school.items.paginate(page: params[:page])
    @school = School.find(params[:school_id])
    @item = current_user.items.build(params[:item])
    if @item.save
      @items << @item
    	flash[:success] = "We added it!"
    	redirect_to school_items_path(@school, @items)
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
