class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.text :appid
      t.text :name
      t.text :desc

      t.timestamps
    end
  end
end
