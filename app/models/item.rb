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

class Item < ActiveRecord::Base
  attr_accessible :content, :school_id

  has_many :reactions
  has_many :wants
  has_many :votes
  belongs_to :user
  belongs_to :school

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :school_id, presence: true
  validates :counter, presence: true


  def plus_one
  	self.counter += 1
  end

  scope :desc, order('items.counter DESC')
end
