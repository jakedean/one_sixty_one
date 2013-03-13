# == Schema Information
#
# Table name: wants
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  item_id              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default(0)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Want < ActiveRecord::Base
  attr_accessible :status, :picture, :item_id

  belongs_to :user
  belongs_to :item
  has_many :personals
  has_attached_file :picture, styles: { medium: "400x400>" }, default_url: "missing.png"
  validates_uniqueness_of :user_id, scope: :item_id
  validates :user_id, presence: true
  validates :item_id, presence: true
  #validates_attachment_presence :picture
  #validates_attachment_size :picture, less_than: 5.megabytes
  #validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png']

end
