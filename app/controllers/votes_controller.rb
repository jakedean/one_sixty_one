class VotesController < ApplicationController

	def create 
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:vote][:item_id])
		@vote = current_user.add_vote(@item)
		#current_user.add_vote(@vote)
		if @vote.save
	      submission_hash = {counter: @item.plus_one}
          @item.update_attributes(submission_hash)
		  flash[:success] = "Thanks for the vote"
		  redirect_to school_user_items_path(@school, current_user)
	    else
	      flash[:error] = "You already voted for that one!"
	      redirect_to school_user_items_path(@school, current_user)
	    end

end
end