class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :desc
      t.string :difficulty
      t.string :category
      t.string :image_filename

      t.timestamps
    end
    add_index :photos, :name, unique: true
    add_index :photos, :category
    add_index :photos, :difficulty
  end
end
