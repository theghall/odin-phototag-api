class Item < ApplicationRecord
  belongs_to :photo
  has_many :locations

  validates :name, presence: true
  validates :top_left_loc, presence: true
  validates :bottom_right_loc, presence: true
end
