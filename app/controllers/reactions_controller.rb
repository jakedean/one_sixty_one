class ReactionsController < ApplicationController

    before_filter :signed_in_user
    
	def new
		@item = Item.find()
	end

	def create
		@user = current_user
		@item = Item.find(params[:item_id])
		@reaction = @item.reactions.build(params[:reaction])
		if @reaction.save
			flash[:success] = "We added your comment"
			redirect_to :back
		else
			redirect_to school_item_path(@school, @item)
		end
	end

	def destroy
		
	end
end
