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

require 'spec_helper'

describe Personal do
  pending "add some examples to (or delete) #{__FILE__}"
end
