# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class School < ActiveRecord::Base
  attr_accessible :name
  
  before_save { |school| school.name = school.name.titleize }

  COLLEGE = /(.*university.*|.*institute.*|.*college.*)/i
  validates :name, presence: true, length: { in: 8..50 }, format: { with: COLLEGE },
                  uniqueness: { case_sensative: false }
end
