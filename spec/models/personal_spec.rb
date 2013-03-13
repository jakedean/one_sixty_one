# == Schema Information
#
# Table name: personals
#
#  id         :integer          not null, primary key
#  want_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string(255)
#  user_id    :integer
#

require 'spec_helper'

describe Personal do

    let!(:school) { FactoryGirl.create(:school) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:item) { user.items.create(content: "This is my item!", school_id: school.id) }
	  let!(:want) { user.wants.create(item_id: item.id) }

	before do
	  @personal = want.personals.build(content: "This is the personal comment!", user_id: user.id) 
	end

  subject { @personal }

  it { should respond_to(:content) }
  it { should respond_to(:want) }
  it { should respond_to(:user_id) }
  its(:want) { should == want }


  it { should be_valid }

  describe "when there is no user_id" do
  	before { @personal.user_id = nil }
  	it { should_not be_valid }
  end

  describe "the accessbile attributes in the personal model" do
  	  it "should not be allowed to access the want_id" do
  		  expect do
  			Personal.new(want_id: want.id)
  		  end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	  end
  end
  
  describe "when there is no content" do
  	  before { @personal.content = " " }
  	  it { should_not be_valid }
  end
  describe "when the content is too long" do
  	  before { @personal.content = "a" * 256 }
  	  it { should_not be_valid }
  end

end
