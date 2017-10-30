class AddOriginalIdToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :original_id, :integer
  end
end
