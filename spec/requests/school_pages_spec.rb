require 'spec_helper'

describe "SchoolPages" do
	subject {page}

	    let(:school) { FactoryGirl.create(:school) }
        let!(@user)  { school.users.create(name: 'jake Dean', email: 'jd@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar') }
        let!(:item) { @user.items.create(content: "The first item.", school_id: school.id) }

        before { sign_in(@user) }

        describe "the show page for the school" do

        	describe "the content of the page initially" do
        		before do 
        			visit school_items_path(school)
        			click_button "Add to the list!"
        			fill_in 'item_content', with: 'This is my awesome item'
        			click_button "Add to the list!" 
        		end

        		it "should have the item that was created already" do
        			it { should have_content('The first item.') }
        			it { should have_content('This is my awesome item') }
        		end

        	end


        	describe "the content of the page after a vote" do
        		before do
        		  visit item_path(item)
        		end

        		expect { click_button "+1" }.to change(Vote, :count).by(1)
        	end
        end
 end



        





