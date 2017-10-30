# == Schema Information
#
# Table name: cooking_processes
#
#  id          :integer          not null, primary key
#  step        :integer
#  description :string
#  kind        :string
#  use_stove   :boolean
#  leavable    :boolean
#  duration    :float
#  movie_start :float
#  movie_end   :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  recipe_id   :integer
#

require 'test_helper'

class CookingProcessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
