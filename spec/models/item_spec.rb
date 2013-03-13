# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  school_id  :integer
#  counter    :integer          default(0)
#  voters     :integer
#

require 'spec_helper'

describe Item do
    let!(:school) { FactoryGirl.create(:school) }
    let!(:other_school) { FactoryGirl.create(:school) }
    let!(:user) { FactoryGirl.create(:user) }
    before do
      @item = user.items.build(content: "This is the item!", school_id: school.id)
    end

  subject { @item }

  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:school) }
  it { should respond_to(:counter) }
  it { should respond_to(:voters) }
  it { should respond_to(:reactions) }
  its(:user) { should == user }
  its(:school) { should == school }


  describe "when the item does not have content" do
  	before { @item.content = " " }
  	it { should_not be_valid }
  end

  describe "when the item is too long" do
  	before { @item.content = 'a' * 141 }
  	it { should_not be_valid }
  end

  describe "when there is a reaction built it should be accessable thru the item" do
    let!(:reaction) { @item.reactions.build(comment: "This was so much fun.") }
    before { @item.save }
    it "should include this reaction in its reactions array" do
      @item.reactions.count == 1
    end
  end


  describe "accessible attributes" do
    it " should not allow acces to the user_id part of the items relationship" do

      expect do
        Item.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  


   describe "when there is not a user_id, needs one because will be build w/ association thru user" do
     before { @item.user_id = nil }
     it { should_not be_valid }
    end

   describe "when there is not an item_id, needs one because will be passed on create" do
     before { @item.school_id = nil }
     it { should_not be_valid }
   end
  end

  describe "the counter when the item has been created" do
    it " should have the counter set to default" do
      @item.counter.should == 0
    end

    describe "the counter should not be valid if it is nil" do
      before { @item.counter = nil }
      it { should_not be_valid }
    end
  end

  describe "which schools should have the item associated with it" do
    before { @item.save }

    describe "the first school" do
      it "should have the association" do
        school.items.should == [@item]
      end
    end

    describe "the second school" do
      it "should not have the association" do
        other_school.items.should == []
      end
    end
  end


  describe "the voting for an item" do

    before { @item.save }

    describe "when a plus 1 vote is given for the first time" do
      let!(:vote) { user.votes.create(item_id: @item.id) }

      #it "should now have a counter of 1" do
        #@item.counter.should == 1
      #end


      it "should contain that vote in its votes array" do
        @item.votes.should == [vote]
      end

       describe "when the plus 1 vote is given a secnd time" do
         let!(:second_vote) { user.votes.create(item_id: @item.id) }

         #it "should still have a counter of 1" do
           #@item.counter.should == 1
         #end

         it "should still only contain the first in its votes array" do
           @item.votes.should == [vote]
          end
        end
    end
  end

end
