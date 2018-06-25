class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :photo, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
