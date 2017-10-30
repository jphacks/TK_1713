class AddMovieUrlToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :movie_url, :string
  end
end
