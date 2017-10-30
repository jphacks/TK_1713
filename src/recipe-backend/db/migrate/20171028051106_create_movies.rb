class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :url
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
