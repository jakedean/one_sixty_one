# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Vote do
  
  #A vote ticks up the counter in the item.  The non-duplicate part is tested in the user_spec.rb.

    let!(:user) { FactoryGirl.create(:user) }
    let!(:item) { FactoryGirl.create(:item) }
  	let!(:vote) { user.votes.build(item_id: item.id) }
  	
  subject { vote }

  it { should respond_to(:item_id) }
  it { should respond_to(:user) }

  it { should be_valid }

    describe "accessible attributes" do
 	  it " should not allow acces to the user_id part of the vote relationship" do
         expect do
 		   Vote.new(user_id: user.id)
 		 end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
 	    end
    end

    describe "there is now one vote so should be able to access" do
      before { vote.save }
 	    it "now have 1 vote you can access through the user" do
           user.votes.count.should == 1
        end
    end

    describe "when there is not a user_id, needs one because will be build w/ association thru user" do
 	  before { vote.user_id = nil }
 	  it { should_not be_valid }
    end

    describe "when there is not an item_id, needs one because will be passed on create" do
 	   before { vote.item_id = nil }
 	   it { should_not be_valid }
    end

end
