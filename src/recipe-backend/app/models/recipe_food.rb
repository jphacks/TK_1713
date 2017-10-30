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

class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
end
