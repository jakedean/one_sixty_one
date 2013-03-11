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

require 'spec_helper'

describe Want do
  pending "add some examples to (or delete) #{__FILE__}"
end
