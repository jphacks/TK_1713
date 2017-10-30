class CreateRecipeFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_foods do |t|
      t.float :amount
      t.integer :servings
      t.references :recipe, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
