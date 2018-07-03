class ChallengeSerializer < ActiveModel::Serializer
  attributes :desc
  has_many :leaderboards
end
