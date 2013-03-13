# == Schema Information
#
# Table name: wants
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  item_id              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default(0)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'spec_helper'

describe Want do
  
  #A want is just a personal item shown on your profile page, has associated personals which are personal comment
  #not associated with the item itself, but rather with a want.

    let!(:school) { FactoryGirl.create(:school) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:item) { user.items.create(content: "this is the item", school_id: school.id) }
  	
    before do
      @want = user.wants.build(item_id: item.id) 
    end
  	
   subject { @want }

  it { should respond_to(:personals) }
  it { should respond_to(:item) }
  it { should respond_to(:user) }
  it { should respond_to(:status) }
  it { should respond_to(:picture_file_name) }
  it { should respond_to(:picture_updated_at) }
  it { should respond_to(:picture_file_size) }
  it { should respond_to(:picture_content_type) }
  its(:user) { should == user }
  its(:item) { should == item }

  it { should be_valid }

 #This is the "personals" section which means personal comments associated with each want. 
 #I a not saying a want has to have a picture because they are created w/out one then they
 #are given one whenever the person completes the task, so want can be created w/out pic.

 describe "accessible attributes" do
 	  it " should not allow acces to the user_id part of the want relationship" do

 		  expect do
 			  Want.new(user_id: user.id)
 		  end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
 	  end
  end

 describe "when there are no personals associated with the want" do
    
 	  it "should not have and personals" do
 	 	  @want.personals.count.should == 0
 	  end
  end

 describe "when there is not a user_id, needs one because will be build w/ association thru user" do
 	  before { @want.user_id = nil }
 	  it { should_not be_valid }
 end

 describe "when there is not an item_id, needs one because will be passed on create" do
 	  before { @want.item_id = nil }
 	  it { should_not be_valid }
 end

  describe "when a user trys to add a want a secnd time" do

    before do
      @want.save
      @dup_want = user.wants.build(item_id: item.id)
      @dup_want.save 
    end
    subject { @dup_want }

    it { should_not be_valid }
  end
end
