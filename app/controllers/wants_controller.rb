class WantsController < ApplicationController

	before_filter :signed_in_user


	def create
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:item_id])
		@want = current_user.wants.build(params[:want])
        if @want.save
          flash[:success] = "You added that item to your list"
		  redirect_to user_path(current_user)
		else
		  flash[:error] = "You already have that on your list silly"
		    redirect_to user_path(current_user)
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

	def destroy
		@want = Want.find(params[:id])
		@want.destroy
		redirect_to user_path(current_user)
	end


	def show
      @title = "My Items"
      @user = User.find(params[:user_id])
      @school = School.find(current_user.school_id)
      @want = Want.find(params[:id])
      @personal_item = Item.find(@want.item_id)
      @personal = Personal.new
	end
	
end
