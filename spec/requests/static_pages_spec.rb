require 'spec_helper'

#I already tested for the right links in the authentication pages file

describe "StaticPages" do
  subject {page}

  let!(:school) { FactoryGirl.create(:schoool) }
  let!(@user)  { school.users.create(name: 'jake Dean', email: 'jd@gmail.com',
                             password: 'foobar', password_confirmation: 'foobar') }

  describe "the static pgs when user is not logged in" do
    describe "the home page" do
        before {visit root_path}

      it { should have_content('161') }
      it { should have_link('Home', href: root_path) } 
      it { should have_link('About', href: about_path) }
      it { should have_link('Sign in', href: signin_path) }
      it { should_not have_link('Users', href: school_users_path(school)) }) }
      it { should have_content('Sign me up') }
      it { should have_content('Log me in') }
    end

    describe "about page" do
      before {visit about_path}

      it { should have_content('161') }
      it { should have_link('Home', href: root_path) } 
      it { should have_link('About', href: about_path) }
      it { should have_link('Sign in', href: signin_path) }
      it { should_not have_link('Users', href: school_users_path(school)) }) }
   end
  end

  describe "the static pages when the user is logged in" do
    describe "the home page" do
      before do
        sign_in(@user)
        visit root_path
      end
      
      it { should have_link('Users', href: school_users_path(school)) }) }
      it { should have_link('My School List', href: school_items_path(school)) }) }
      it { should have_link('Sign out', href: signout_path ) }
      it { should_not have_content('Sign me up') }
      it { should_not have_content('Log me in') }
    end

    describe "the about page" do
      before do
        sign_in(@user)
        visit root_path
      end
      
      it { should have_link('Users', href: school_users_path(school)) }) }
      it { should have_link('My School List', href: school_items_path(school)) }) }
      it { should have_link('Sign out', href: signout_path ) }
    end
  end
end
