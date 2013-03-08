# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  attr_accessible :content

  has_many :reactions
  belongs_to :school

  validates :content, presence: true, length: { maximum: 140 }

end
