class AddServingToRecipeFood < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_foods, :serving_name, :string
  end
end
