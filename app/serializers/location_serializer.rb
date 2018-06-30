class LocationSerializer < ActiveModel::Serializer
  attributes :bottom_left_loc, :top_left_loc, :top_right_loc, :bottom_right_loc
  belongs_to :item
end
