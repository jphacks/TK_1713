# == Schema Information
#
# Table name: creates
#
#  id         :integer          not null, primary key
#  recipe_tag :string
#  recipe_id  :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CreateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
