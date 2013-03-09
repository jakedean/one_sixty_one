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

class Item < ActiveRecord::Base
  attr_accessible :content, :counter

  has_many :reactions
  belongs_to :user
  belongs_to :school

  validates :content, presence: true, length: { maximum: 140 }


  def plus_one
  	self.counter += 1
  end

  scope :desc, order('items.counter DESC')
end
