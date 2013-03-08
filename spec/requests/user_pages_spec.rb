require 'spec_helper'

describe "UserPages" do
	subject {page}

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		let(:school) { FactoryGirl.create(:school) }

		before { visit school_user_path(school, user) }

		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

  describe "signup page" do
  	before {visit signup_path}
    its(:source) { should have_selector('h1', text: 'Sign up')}
  	its(:source) { should have_selector('title', text: full_title('Sign up')) }
  end

  
end
