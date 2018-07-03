class Leaderboard < ApplicationRecord
  belongs_to :challenge
  default_scope -> { order(best_time: :asc) }

  validates :name, presence: true
  validates :best_time, presence: true, numericality: true

  def self.query(query_params)
    where(challenge_id: Challenge.get_id(query_params))
  end
end
