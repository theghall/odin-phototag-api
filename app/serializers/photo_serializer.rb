class PhotoSerializer < ActiveModel::Serializer
  attributes :name, :desc, :difficulty, :category, :image_filename
  has_many :items
end
