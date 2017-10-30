class AddUnitToRecipeFood < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_foods, :unit, :string
  end
end
