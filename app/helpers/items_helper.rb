module ItemsHelper


  def plus_one
  	self.counter += 1
  	self.save
  end

  def add_to_voters
  	current_user.id >> self.voters
  end 
end
