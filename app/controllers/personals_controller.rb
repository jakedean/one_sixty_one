class PersonalsController < ApplicationController

	def create
		@want = Want.find(params[:want_id])
		@personal = @want.personals.build(params[:personal])
		@personal.user_id = current_user.id
		if @personal.save
			flash[:success] = 'Your comment was added'
			redirect_to :back
		else
			flash[:error] = 'Your coment was not added try again'
			redirect_to :back
		end
	end
end
