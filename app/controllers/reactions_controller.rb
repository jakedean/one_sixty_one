class ReactionsController < ApplicationController


	def new
		@item = Item.find()
	end

	def create
		@user = current_user
		@item = Item.find(params[:item_id])
		@reaction = @item.reactions.new(params[:reaction])
		@reaction.user_id = @user.id
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
