class Challenge < ApplicationRecord
  has_many :leaderboards

  validates :name, presence: true
  validates :desc, presence: true

end
