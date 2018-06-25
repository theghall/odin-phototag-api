class Leaderboard < ApplicationRecord
  has_many :levels

  validates :name, presence: true
end
