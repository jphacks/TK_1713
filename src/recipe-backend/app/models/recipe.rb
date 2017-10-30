# == Schema Information
#
# Table name: recipes
#
#  id            :integer          not null, primary key
#  name          :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  movie_url     :string
#  original_id   :string
#  thumbnail_url :string
#

class Recipe < ApplicationRecord
    belongs_to :category
    has_many :recipe_foods
    has_many :cooking_processes
    # has_many :tags, through:
end
