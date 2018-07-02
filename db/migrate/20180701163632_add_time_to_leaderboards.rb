class AddTimeToLeaderboards < ActiveRecord::Migration[5.2]
  def change
    add_column :leaderboards, :best_time, :float
  end
end
