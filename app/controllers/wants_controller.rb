class WantsController < ApplicationController

	def create
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:item_id])
		@want = current_user.wants.build(params[:want])
        if @want.save
          flash[:success] = "You added that item to your list"
		  redirect_to school_user_path(@school, current_user)
		else
		  flash[:error] = "You already have that on your list silly"
		    redirect_to school_user_path(@school, current_user)
		end
	end

	def update
		@want = Want.find(params[:id])
		if @want.update_attributes(params[:want])
		flash[:success] = "Awesome!"
		redirect_to :back
	    else
	    	flash[:error] = "That did not work"
	    	redirect_to :back
	    end
	end

	def show
		@want = Want.find(params[:id])
		@item = Item.find(@want.item_id)
	end
end
