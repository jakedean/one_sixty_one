class Want < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :status

  belongs_to :user
  belongs_to :item
  validates_uniqueness_of :user_id, scope: :item_id
end
