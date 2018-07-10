class ChallengeSerializer < ActiveModel::Serializer
  attributes :appid, :name, :desc, :photo_name, :meta_data
  has_many :leaderboards
end
