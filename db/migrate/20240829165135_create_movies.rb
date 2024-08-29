class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :overview
      t.text :poster
      t.decimal :rating, precision: 2, scale: 1

      t.timestamps
    end
  end
end
