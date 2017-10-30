class CreateCookingProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :cooking_processes do |t|
      t.integer :step
      t.string :description
      t.string :kind
      t.boolean :use_stove
      t.boolean :leavable
      t.float :duration
      t.float :movie_start
      t.float :movie_end

      t.timestamps
    end
  end
end
