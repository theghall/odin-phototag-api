class ItemSerializer < ActiveModel::Serializer
  attributes :name, :bottom_left_loc, :top_left_loc, :top_right_loc, :bottom_right_loc
  belongs_to :item
end
