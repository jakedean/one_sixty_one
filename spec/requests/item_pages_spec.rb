require 'spec_helper'

describe "ItemPages" do

	subject {page}

		let(:school) { FactoryGirl.create(:school) }
        let!(@user)  { school.users.create(name: 'jake Dean', email: 'jd@gmail.com',
    	                       password: 'foobar', password_confirmation: 'foobar') }
        let!(:item) { @user.items.create(content: "item", school_id: school.id) }
        let!(:item_2) { @user.items.create(content: "item 2", school_id: school.id) }

		let(:reaction) { item.reactions.create(user_id:user.id) }

		before { sign_in(@user) }

		describe "item creation" do
			before { visit new_item_path }

			describe "with invalid information" do
				it "should not create an item" do
					expect { click_button "Add to the list" }.not_to change(Item, :count)
				end

				describe "the error messages that should be there" do
					before { click_button "Add to the list" }
					it { should have_content('error') }
				end
			end



			describe "with valid information" do
				before { fill_in 'item_content', with: 'This is my awesome item' }
				it "should create an item" do
					expect { click_button "Add to the list" }.to change(Item, :count).by(1)
				end
			end
	    end

	     #describe item destruction here!!
  


	    describe "the ordering on the items index page" do
	    	before { visit item_path(item) }

	    	describe "the vote count for item should now be 1" do
	    		expect { click_button "Add" }.to change(Vote, :count).by(1)
	    	end
	    end


	    describe "making a response to an item" do
	    	before { visit item_path(item) }
	    	  before  { fill_in 'reaction_comment', with: 'This is the reaction' }
	    	  it "should create a reaction for that item" do
	    	  	expect { click_button "Add your comment!" }.to change(Reaction, :count).by(1)
	    	  end
	    end

end
