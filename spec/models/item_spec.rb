# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :integer
#

require 'spec_helper'

describe Item do
  
  before { @item = Item.new(content: 'Shag in the stacks') }

  subject { @item }

  describe "when the item does not have content" do
  	before { @item.content = " " }
  	it { should_not be_valid }
  end

  describe "when the item is too long" do
  	before { @item.content = 'a' * 141 }
  	it { should_not be_valid }
  end

end
