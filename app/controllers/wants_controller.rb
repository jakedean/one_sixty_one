class WantsController < ApplicationController

	def create
		@school = current_user.school_id
		@item = Item.find(params[:want][:item_id])
		current_user.add_item(@item)
		redirect_to school_user_path(@school, current_user)
	end
end
