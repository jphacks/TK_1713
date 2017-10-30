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

class CookingProcess < ApplicationRecord
    belongs_to :recipe
end
