class Challenge < ApplicationRecord
  has_many :leaderboards

  validates :name, presence: true
  validates :desc, presence: true

  def self.query(query_params)
    where(query_params).first
  end

  def self.get_id(query_params)
    challenge = Challenge.query(query_params)
    challenge.nil? ? challenge : challenge.id
  end

end