# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  email                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  password_digest      :string(255)
#  remember_token       :string(255)
#  school_id            :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

require 'spec_helper'

describe User do
  let!(:school) { FactoryGirl.create(:school) }
  before { @user = school.users.build(name: "Jake Dean", email: "jdean@example.com",
  	                        password: 'foobar', password_confirmation: 'foobar') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:picture) }
  it { should respond_to(:items) }
  it { should respond_to(:reactions) }
  it { should respond_to(:wants) }
  it { should respond_to(:relationships) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:personal_items) }
  it { should respond_to(:votes) }
  it { should respond_to(:followers) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:add_item) }
  it { should respond_to(:add_vote) }
  it { should respond_to(:follow!) }
  it { should respond_to(:following?) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:picture_file_name) }
  it { should respond_to(:picture_updated_at) }
  it { should respond_to(:picture_file_size) }
  it { should respond_to(:picture_content_type) }
  
  it { should be_valid }

#Basic Validations Here

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

  describe "password stuff" do

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


  describe "the remember_token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

#THE PERSONAL ITEMS SECTION


  describe "personal items being added to users page" do
    before { @user.save }
    let(:new_item) { @user.items.create(content: "first item", school_id: @user.school_id) }
    let!(:newer_item) { @user.items.create(content: "second item", school_id: @user.school_id) }
    let!(:user_want) do
      @user.wants.create(item_id: new_item.id)
    end
    it "should have a personal item now" do
      @user.personal_items.should == [new_item]
    end

    it "should have a want count of 1" do
      @user.wants.count.should == 1
    end
    describe "a duplicate wants situation" do
      before { @user_wants = @user.wants << user_want }
      it "should not allow duplicate wants" do
        @user.personal_items.count == 1
      end
    end

    describe "adding an additional want" do
      let!(:newer_want) do
      @user.wants.create(item_id: newer_item.id)
    end
      before { @user_wants = @user.wants << newer_want }
      it " should allow this want to go through" do
        @user.personal_items.count == 2 
      end
    end
  end

#THE VOTES SECTION dups vs. non dups

  describe "votes being added to an item" do
    before { @user.save }
    let(:new_item) { @user.items.create(content: "first item", school_id: @user.school_id) }
    let!(:newer_item) { @user.items.create(content: "second item", school_id: @user.school_id) }
    let!(:new_vote) do 
      @user.votes.create(item_id: new_item.id)
    end

    it " should have a vote" do
      @user.votes.count.should == 1
    end

    describe "with dup votes" do
       before { @dup_votes = @user.votes << new_vote }

      it "should not allow duplicate votes" do
        @user.votes.count.should == 1
      end
    end

    describe "adding a nondup vote" do
      let!(:newer_vote) do 
      @user.votes.create(item_id: newer_item.id)
    end

      before { @non_dup_votes = @user.votes << newer_vote }

      it "should allow non dup votes" do
        @user.votes.count.should == 2
      end

      describe "adding this newer vote again" do
        before { @non_dup_votes = @user.votes << newer_vote }
        it " should not allow this vote this time" do
         @user.votes.count.should == 2
        end
      end 
   end
  end

  #THE REACTIONS SECTION

  describe "reactions by a user" do
    before do
      @user.save
      @item = @user.items.build(content: "This is the item!", school_id: school.id)
      @item.save
    end

  let!(:user_reaction) { @item.reactions.create(comment: "This is the reaction", user_id: @user.id) }

    it "should also have a reaction associated with the user" do
      @user.reactions.count.should == 1
    end
  end

  #THE FOLLOWING/FOLLOWED SECTION


  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end

  describe "unfollowing" do
    before do
      @user.unfollow!(other_user)
    end

    it { should_not be_following(other_user) }
    its(:followed_users) { should_not include(other_user) }

  end
 end
end

