class AddThumbnailUrlToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :thumbnail_url, :string
  end
end
