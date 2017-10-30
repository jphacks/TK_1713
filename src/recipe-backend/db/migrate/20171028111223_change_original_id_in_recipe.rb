class ChangeOriginalIdInRecipe < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :original_id, :string
  end
end
