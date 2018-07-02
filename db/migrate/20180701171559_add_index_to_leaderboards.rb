class AddIndexToLeaderboards < ActiveRecord::Migration[5.2]
  def change
    add_index :leaderboards, [:challenge_id, :name], unique: true
  end
end
