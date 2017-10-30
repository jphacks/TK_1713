class AddAmountNameToRecipeFood < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_foods, :amount_name, :string
  end
end
