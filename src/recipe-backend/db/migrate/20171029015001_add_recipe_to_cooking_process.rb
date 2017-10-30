class AddRecipeToCookingProcess < ActiveRecord::Migration[5.1]
  def change
    add_reference :cooking_processes, :recipe, foreign_key: true
  end
end
