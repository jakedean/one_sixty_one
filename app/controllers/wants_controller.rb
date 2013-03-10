class WantsController < ApplicationController

	def create
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:want][:item_id])
		@want = current_user.add_item(@item)
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
		hash = { status: 1 }
		@want.update_attributes(hash)
		flash[:success] = "Nice work!"
		redirect_to :back
	end

	def show
		@want = Want.find(params[:id])
		@item = Item.find(@want.item_id)
	end
end
