# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe School do

	 before { @school = School.new(name: "Cornell University") }

	 subject { @school }

  it { should respond_to(:name) }

  it { should be_valid }


  describe "when there is no name for the school" do
    before { @school.name = " " }
    it { should_not be_valid }
  end

  describe "when the name is too long" do
    before { @school.name = "a" * 51 }
    it { should_not be_valid }
   end 

   describe "when the name is too short" do
   	before { @school.name = "a" * 7 }
   	it { should_not be_valid }
   end

   describe "when the format is good" do
   	it "should be valid" do
   	names = ['Cornell University', 'C Institute of Tech', 'Dartmouth College']
   	names.each do |good_name|
   	  @school.name = good_name
   	  @school.should be_valid 
    end
   end
  end

  describe "when the format is bad" do
  	it "should not be valid" do
  	names = ['Cornell U.', 'CIT', 'Dartmouth Colluge']
  	names.each do |bad_name|
  		@school.name = bad_name
  		@school.should_not be_valid 
  	end
   end
  end

  describe "when someone tries a duplicate school" do
  	  before do
  	    dup_school = @school.dup
  	    dup_school.name = @school.name.downcase
  	    dup_school.save
      end
      it { should_not be_valid }
  end
end
