# == Schema Information
#
# Table name: reactions
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reaction < ActiveRecord::Base
  attr_accessible :comment

  belongs_to :item

  validates :comment, presence: true, length: { maximum: 140 }
end
