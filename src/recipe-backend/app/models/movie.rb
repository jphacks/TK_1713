# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  url        :string
#  recipe_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Movie < ApplicationRecord
  belongs_to :recipe
end
