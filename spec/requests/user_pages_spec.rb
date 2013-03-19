require 'spec_helper'

describe "UserPages" do
	subject {page}

	    let(:school) { FactoryGirl.create(:school) }
        let!(@user)  { school.users.create(name: 'jake Dean', email: 'jd@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar') }
      let!(@user_2)  { school.users.create(name: 'jake Dean', email: 'jdean74@gmail.com',
                             password: 'foobar', password_confirmation: 'foobar') }
        let!(:item) { @user.items.create(content: "item", school_id: school.id) }


	end

  end

  
end



describe "follow/unfollow buttons" do
    
    before { sign_in @user }

    describe "following a user" do
      before { visit user_path(@user_2) }

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
end


describe "feed actions" do
  before do
    sign_in @user
    visit school_items_path(school)
    click_link "item"
    click_button "Add"
    sign_out @user
    sign _in @user_2
    visit user_path(@user)
    click_button "Follow"
    click_link 'Recent Activity'
  end

  it { should have_content("#{@user.name}")}
  it { should have_content('item') }
end
end

