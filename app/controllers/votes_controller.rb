class VotesController < ApplicationController

	def create 
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:item_id])
		@vote = current_user.votes.build
		@vote.item_id = @item.id
		if @vote.save
		  updated_hash = { counter: @item.plus_one}
	      @item.update_attributes(updated_hash)
		  flash[:success] = "Thanks for the vote"
		  redirect_to school_user_items_path(@school, current_user)
	    else
	      flash[:error] = "You already voted for that one!"
	      redirect_to school_user_items_path(@school, current_user)
	    end

end
end