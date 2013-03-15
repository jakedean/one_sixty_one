require 'spec_helper'

describe "AuthenticationPages" do 

  let!(:school) { FactoryGirl.create(:school) }
  before do
    @user = school.users.build(name: 'jake Dean', email: 'jd@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar')

    @other_user = school.users.build(name: 'jake Dean', email: 'jd2@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar')
   end

  subject { page }
  
  describe "visiting the signin page" do
  	 before { visit signin_path }

  	  it { should have_content('Sign in') }
   	  it { should have_selector('title', text: 'Sign in') }
   end


   describe "the actual sign in process" do

   	 before { visit signin_path }

     describe "logging in with invalid info" do
     	 before { click_button "Sign in" }
      	 it { should have_content('Sign in') }
     	 it { should have_selector('div.alert.alert-error', content: 'That was not') }

         describe "going to a different page to see if flash error goes away" do
     	      before { click_link "About" }
     	      it { should_not have_selector('div.alert.alert-error') }
          end
       end

      describe "logging in with valid data" do
          
          before do 
          	@user.save
          	sign_in(@user) 
          end

          it { should have_content("#{@user.name}") }
          it { should have_link("Home", href: root_path) }
          it { should have_link("About", href: about_path) }
          it { should have_link("My School List", href: school_items_path(school)) }
          it { should have_link("Users", href: school_users_path(school)) }
          it { should have_link("My Profile", href: school_user_path(school, @user)) }
          it { should have_link("Sign out", href: signout_path) }
      
          describe "and the signout" do
             before { click_link "Sign out" }
          	 it { should have_content("Sign in") }
           end
        end
   end

   describe "authorization" do

   	  describe "for non signed-in users" do
   		  before do 
   		  	@user.save 
   		  end
   		  let!(:item) { @user.items.create(content: "this is my content", school_id: school.id) }

   		  describe "attempting to visit a protected page" do
   			  before do
   				   visit school_items_path(school)
   				   sign_in(@user)
   			   end

   				  it { should have_content('Add to list!') }
   			 
   		   end

   		   describe "in the item controller" do
   		   	 describe "not allowing acces to the new item" do
   		   	 	before { visit new_item_path }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 describe "not allowing acces to the index page" do
   		   	 	before { visit school_items_path(school) }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 describe "not allowing acces to the show page" do
   		   	 	before { visit item_path(item) }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 describe "not allowing acces to the create action" do
   		   	 	before { post items_path  }
   		   	 	specify { response.should redirect_to(signin_path) }
   		   	 end
   		   	end

   		   	describe "in the personals controller" do
   		   		let!(:want) { @user.wants.create(item_id: item.id) }
   		   		let!(:personal) { want.personals.create(user_id: @user.id) }
   		   		describe "not letting access to create action" do
   		   		  before { post want_personals_path(want) }
   		   		  specify { response.should redirect_to(signin_path) }
   		   		end
   		    end


   		    describe "in the reactions controller" do
   		    	let!(:reaction) { item.reactions.create(user_id: @user.id) }
   		    	describe "not allowing acces to the new action" do
   		   	 	   before { visit new_item_reaction_path(item) }
   		   	 	  it { should have_selector('title', text: "Sign in") }
   		   	    end

   		   	    describe "not allowing access to the create action" do
   		   	    	before { post item_reactions_path(item) }
   		   	    	specify { response.should redirect_to(signin_path) }
   		   	    end

   		   	    describe "not allowing access to the destroy action" do
   		   	    	before { delete item_reactions_path(item) }
   		   	    	specify { response.should redirect_to(signin_path) }
   		   	    end

   		   	end

   		   	describe "in the relationships controller" do
   		   		before { @other_user.save }
   		   		let!(:relationship) { @user.relationships.create(followed_id: @other_user.id) }

   		   	    describe "not allowing access to the create action" do
   		   	    	before { post relationships_path }
   		   	    	specify { response.should redirect_to(signin_path) }
   		   	    end

   		   	    describe "not allowing access to the destroy action" do
   		   	    	before { delete relationship_path(relationship) }
   		   	    	specify { response.should redirect_to(signin_path) }
   		   	    end

   		   	end

            describe "in the schools controller" do
            	describe "not allowing acces to the show page" do
   		   	 	before { visit school_path(school) }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 
   		   	 describe "not allowing acces to the delete action" do
   		   	 	before { delete school_path(school)  }
   		   	 	specify { response.should redirect_to(signin_path) }
   		   	 end
   		   	end

   		   	describe "in the user controller" do
   		   	 describe "not allowing acces to the index page" do
   		   	 	before { visit school_users_path(school) }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 describe "not allowing acces to the show page" do
   		   	 	before { visit user_path(@user) }
   		   	 	it { should have_selector('title', text: "Sign in") }
   		   	 end
   		   	 
   		   	 describe "not allowing acces to the update action" do
   		   	 	before { put school_user_path(school, @user) }
   		   	 	specify { response.should redirect_to(signin_path) }
   		   	 end

   		   	 describe "not allowing acces to the delete action" do
   		   	 	before { delete school_user_path(school, @user) }
   		   	 	specify { response.should redirect_to(signin_path) }
   		   	  end

   		   	 describe "not allowing access to the following page" do
               before { visit following_school_user_path(school, @user) }
               it { should have_selector('title', text: "Sign in") }
             end

             describe "not allowing access to the followers page" do
              before { visit followers_school_user_path(school, @user) }
              it { should have_selector('title', text: "Sign in") }
             end
             describe "not allowing access to the personal items page" do
               before { visit personal_item_school_user_path(school, @user) }
               it { should have_selector('title', text: "Sign in") }
             end
            end


            describe "in the votes controller" do
            	describe "not allowing acces to the create action" do
   		   	 	  before { post item_votes_path(item) }
   		   	 	  specify { response.should redirect_to(signin_path) }
   		   	    end
   		   	end



   		   	describe "in the wants controller" do
   		   		describe "not allowing acces to the create action" do
   		   	 	  before { post item_wants_path(item) }
   		   	 	  specify { response.should redirect_to(signin_path) }
   		   	    end
   		   	 describe "not allowing acces to the update action" do
   		   	 	let!(:want) { @user.wants.create(item_id: item.id) }
   		   	 	before { put want_path(want) }
   		   	 	specify { response.should redirect_to(signin_path) }
   		   	 end

   		   	  #describe "not allowing access to the show page" do
   		   	  #end
   		   	end
       end
   	end   
end