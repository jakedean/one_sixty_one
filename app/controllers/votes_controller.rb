class VotesController < ApplicationController


  before_filter :signed_in_user
	def create 
		@school = School.find(current_user.school_id)
		@item = Item.find(params[:item_id])
		@vote = current_user.votes.build(item_id: @item.id)
		if @vote.save
	      @item.counter += 1
	      @item.save
		  flash[:success] = "Thanks for the vote"
		  redirect_to school_items_path(@school)
	    else
	      flash[:error] = "You already voted for that one!"
	      redirect_to school_items_path(@school)
	    end
    end
end