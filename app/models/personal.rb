# == Schema Information
#
# Table name: personals
#
#  id         :integer          not null, primary key
#  want_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string(255)
#  user_id    :integer
#

class Personal < ActiveRecord::Base
  attr_accessible :content, :user_id

  belongs_to :want

  validates :want_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }


  def add_personal_comment!(want)
  	self.personals.create(want_id: want.id)
  end
end
