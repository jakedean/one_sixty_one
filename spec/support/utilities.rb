
	def full_title(title)
		base_title = 'One Sixty One'
		if title.empty?
			return base_title
		else
			return "#{base_title} | #{title}"
		end
	end



	def sign_in(user)
       visit signin_path
       fill_in "Email",    with: @user.email
       fill_in "Password", with: @user.password
       click_button "Sign in"
       # Sign in when not using Capybara as well.
       cookies[:remember_token] = @user.remember_token
    end