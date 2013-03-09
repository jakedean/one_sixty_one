# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  school_id       :integer
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

  before { @user = User.new(name: "Jake Dean", email: "jdean@example.com",
  	                        password: 'foobar', password_confirmation: 'foobar') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }

 describe "when the name is not present" do
 	before { @user.name = " " }
 	it { should_not be_valid }
 end

 describe "when the name is too long" do
 	before { @user.name = 'a' * 51 }
    it { should_not be_valid }
 end

 describe "when email is not present" do
 	before { @user.email = "" }
 	it { should_not be_valid }
 end

 describe "when an email is of the wrong form" do
 	it "should be invalid" do

 	  emails = %w[foo.bar@123 foo_atgmail.com foo23@example]
 	  emails.each do |bad_address|
        @user.email = bad_address
        @user.should_not be_valid
      end
    end
  end

  describe "when an email address has the right form" do
  	it "should be valid" do
  		emails = %w[jdean07@gmail.com jdean_0-7@cornell.edu m23.dean@gmail.jp]
  		emails.each do |good_address|
  			@user.email = good_address
  			@user.should be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when the password is not there at all" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "when there is a mismatch with the passwords" do
  	before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe " when a password confirmation is set to nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "user with a password that is too short" do
  	before { @user.password = @user.password_confirmation = 'a' * 3 }
  	it { should_not be_valid }
  end


  describe "responding to the authenticate method" do
  	before { @user.save }
  		let(:found_user) {User.find_by_email(@user.email)} 

  	describe "when the password is authenticated" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "when the password is not authenticated" do
    	let(:user_for_invalid_password) {found_user.authenticate('not_valid')}
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password. should be_false }
     end
   end
end
