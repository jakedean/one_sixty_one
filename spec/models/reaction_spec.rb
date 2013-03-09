# == Schema Information
#
# Table name: reactions
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#

require 'spec_helper'

describe Reaction do
  
  before { @reaction = Reaction.new(comment: 'This was really fun, you should try') }
  subject { @reaction }


  describe "when there is nothing in the comment" do
  	before { @reaction.comment = " " }
  	it { should_not be_valid }
  end

  describe "when the comment is too long" do
  before { @reaction.comment = "a" * 141 }
    it { should_not be_valid }
   end 
end
