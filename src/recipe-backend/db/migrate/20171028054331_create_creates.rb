class CreateCreates < ActiveRecord::Migration[5.1]
  def change
    create_table :creates do |t|
      t.string :recipe_tag
      t.references :recipe, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
