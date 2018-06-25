class Level < ApplicationRecord
  belongs_to :leaderboard

  validates :difficulty, presence: true
  validates :best_time, presence: true
end
