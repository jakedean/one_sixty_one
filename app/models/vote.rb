class Vote < ActiveRecord::Base
  attr_accessible :item_id, :user_id

  belongs_to :user

  validates_uniqueness_of :user_id, scope: :item_id
end
