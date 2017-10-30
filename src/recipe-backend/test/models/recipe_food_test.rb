# == Schema Information
#
# Table name: recipe_foods
#
#  id           :integer          not null, primary key
#  amount       :float
#  servings     :integer
#  recipe_id    :integer
#  food_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  unit         :string
#  serving_name :string
#  amount_name  :string
#

require 'test_helper'

class RecipeFoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
