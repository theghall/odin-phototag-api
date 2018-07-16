class DropIndexFromLeaderboard < ActiveRecord::Migration[5.2]
  def change
    remove_index :leaderboards, column: [:challenge_id, :name]
  end
end
