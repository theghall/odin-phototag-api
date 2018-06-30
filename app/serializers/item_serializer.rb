class ItemSerializer < ActiveModel::Serializer
  attributes :name
  belongs_to :item
  has_many :locations
end
