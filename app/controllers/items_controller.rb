class ItemsController < ApplicationController
  
  def index 
  	@school = School.find(params[:id])
  	@items = @school.Item.paginate(page: params[:page])
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
