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

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
