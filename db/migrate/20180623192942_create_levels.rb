class CreateLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :levels do |t|
      t.references :leaderboard, foreign_key: true
      t.text :difficulty
      t.float :best_time

      t.timestamps
    end
  end
end
