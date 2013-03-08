require 'spec_helper'

describe "ItemPages" do
	subject {page}

	describe "profile page" do
		let(:item) { FactoryGirl.create(:item) }
		let(:school) { FactoryGirl.create(:school) }
		let(:reaction) { FactoryGirl.create(:reaction) }

		before { visit school_item_path(school, item) }

		#it { should have_selector('h1', text: item.content) }
		#it { should have_selector('title', text: item.content) }
	end
  
end
