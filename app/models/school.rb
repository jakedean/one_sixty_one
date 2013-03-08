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
  has_many :users
  has_many :items
  
  before_save { |school| school.name = school.name.titleize }

  COLLEGE = /(.*university.*|.*institute.*|.*college.*)/i
  validates :name, presence: true, length: { in: 8..50 }, format: { with: COLLEGE, message: 'is not valid, make sure you use the full name of your school.' },
                  uniqueness: { case_sensative: false }
end
