module ApplicationHelper

	def full_title(title)
		base_title = 'One Sixty One'
		if title.empty?
			return base_title
		else
			return "#{base_title} | #{title}"
		end
	end

	def plus_one
  	self.counter += 1
  	self.save
  end

  
end
