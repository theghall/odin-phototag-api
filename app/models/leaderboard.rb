class Leaderboard < ApplicationRecord
  belongs_to :challenge

  validates :name, presence: true
  validates :best_time, presence: true, numericality: true
end
