class ChallengeSerializer < ActiveModel::Serializer
  attributes :appid, :name, :desc, :photo_name
  has_many :leaderboards
end
