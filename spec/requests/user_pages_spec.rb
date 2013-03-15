require 'spec_helper'

describe "UserPages" do
	subject {page}

	    let(:school) { FactoryGirl.create(:school) }
        let!(@user)  { school.users.create(name: 'jake Dean', email: 'jd@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar') }
        let!(:item) { @user.items.create(content: "item", school_id: school.id) }

        before { sign_in(@user) }


	end

  end

  
end



describe "follow/unfollow buttons" do
    let(:other_user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "following a user" do
      before { visit user_path(other_user) }

      it " should increment the followed user count" do
        expect do
          click_button "Follow"
        end.to change(user.followed_users, :count).by(1)
      end

      it "should increment to other users followers" do
        expect do
          click_button "Follow"
        end.to change(other_user.followers, :count).by(1)
      end
      
      describe "toggling the button" do
        before { click_button "Follow" }
        it { should have_selector('input', value: "Unfollow") }
      end
    end


    describe "unfollowing a user" do
      before do
        user.follow!(other_user)
        visit user_path(other_user)
      end

      it "should decrease the followed user count" do
        expect do
          click_button "Unfollow"
        end.to change(user.followed_users, :count).by(-1)
      end

      it "should decrease the other users followers" do
        expect do
          click_button "Unfollow"
        end.to change(other_user.followers, :count).by(-1)
      end

      describe "toggling the button" do
        before { click_button "Unfollow" }
        it { should have_selector('input', value: "Unfollow") }
      end
     end
    end
 end

describe "Signup page" do

  before { visit signup_path }


  it { should have_content('Sign up') }
  it { should have_selector('title', :content => full_title('Sign up')) }
 end

describe "index page" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
    visit users_path
  end

  it { should have_selector('title', text: 'All users') }
  it { should have_content('All users') }
