class RenameBestTimeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :leaderboards, :best_time, :challenge_time
  end
end
