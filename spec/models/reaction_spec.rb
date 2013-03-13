# == Schema Information
#
# Table name: reactions
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#  user_id    :integer
#

require 'spec_helper'

describe Reaction do

    let!(:school) { FactoryGirl.create(:school) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:item) { user.items.create(content: "This is my item!", school_id: school.id) }

    before do
      @reaction = item.reactions.build(comment: "This is the reaction!", user_id: user.id) 
    end

  subject { @reaction }

  it { should respond_to(:comment) }
  it { should respond_to(:item) }
  it { should respond_to(:user_id) }
  its(:item) { should == item }


  it { should be_valid }

  describe "when there is no user_id" do
    before { @reaction.user_id = nil }
    it { should_not be_valid }
  end

  describe "the accessbile attributes in the reactions model" do
       it "should not be allowed to access the item_id" do
           expect do
             Reaction.new(item_id: item.id)
          end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
       end
    end
  
  describe "when there is no content" do
      before { @reaction.comment = " " }
      it { should_not be_valid }
  end


  describe "when the content is too long" do
      before { @reaction.comment = "a" * 256 }
      it { should_not be_valid }
  end
end
