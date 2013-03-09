# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  school_id       :integer
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  has_many :items
  has_many :reactions
  has_many :wants, dependent: :destroy
  has_many :desires, through: :wants, source: :item

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGREX },
                                    uniqueness: { case_sensative: false }
   validates :password, presence: true, length: { minimum: 6 }
   validates :password_confirmation, presence: true




  def add_item(item)
    self.wants.create(item_id: item.id)
  end

   private

   def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
   end
end
