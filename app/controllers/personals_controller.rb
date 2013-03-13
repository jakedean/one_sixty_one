class PersonalsController < ApplicationController


   before_filter :signed_in_user

   
	def create
		@want = Want.find(params[:want_id])
		@personal = @want.personals.build(params[:personal])
		if @personal.save
			flash[:success] = 'Your comment was added'
			redirect_to :back
		else
			flash[:error] = 'Your coment was not added try again'
			redirect_to :back
		end
	end
end
