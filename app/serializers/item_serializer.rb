class ItemSerializer < ActiveModel::Serializer
  attributes :name, :top_left_loc, :bottom_right_loc
  belongs_to :item
end
