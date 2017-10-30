class CreateCookwares < ActiveRecord::Migration[5.1]
  def change
    create_table :cookwares do |t|
      t.string :name

      t.timestamps
    end
  end
end
