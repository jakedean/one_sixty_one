# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  email                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  password_digest      :string(255)
#  remember_token       :string(255)
#  school_id            :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :picture
  has_secure_password

  has_many :items
  has_many :reactions
  has_many :wants, dependent: :destroy
  has_many :personal_items, through: :wants, source: :item
  has_many :votes, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_attached_file :picture, styles: { small: "300x300", icon: "100x100" }, default_url: "missing.png", :path => "images/:id/:style_:basename.:extension"

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

  def add_vote(item)
    self.votes.create(item_id: item.id)
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

   private

   def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
   end


end
