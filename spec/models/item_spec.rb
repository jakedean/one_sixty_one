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
