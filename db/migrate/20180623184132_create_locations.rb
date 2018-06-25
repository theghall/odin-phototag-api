class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :item, foreign_key: true
      t.text :bottom_left_loc
      t.text :top_left_loc
      t.text :top_right_loc
      t.text :bottom_right_loc

      t.timestamps
    end
  end
end
