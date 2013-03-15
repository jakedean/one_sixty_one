# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base

  attr_accessible :item_id

  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :user_id, scope: :item_id
  validates :user_id, presence: true
  validates :item_id, presence: true


  scope :desc, order('wants.updated_at DESC')
end
