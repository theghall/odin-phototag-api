class AddReferenceToLeaderboard < ActiveRecord::Migration[5.2]
  def change
    add_reference :leaderboards, :challenge, foreign_key: true
  end
end
