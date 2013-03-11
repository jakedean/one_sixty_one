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
  attr_accessible :content

  belongs_to :want


  def add_personal_comment!(want)
  	self.personals.create(want_id: want.id)
  end
end
