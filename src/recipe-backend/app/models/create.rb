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

class Create < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag
end
