class Location < ApplicationRecord
  belongs_to :item

  validates :bottom_left_loc, presence: true
  validates :top_left_loc, presence: true
  validates :top_right_loc, presence: true
  validates :bottom_right_loc,  presence: true
end
