# == Schema Information
#
# Table name: reactions
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer
#  user_id    :integer
#

class Reaction < ActiveRecord::Base
  attr_accessible :comment, :user_id

  belongs_to :item
  belongs_to :user

  validates :user_id, presence: true
  validates :item_id, presence: true

  validates :comment, presence: true, length: { maximum: 255 }
end
