class Photo < ApplicationRecord
  validates :name, presence: true
  validates :desc, presence: true
  validates :difficulty, presence: true
  validates :category, presence: true
  validates :image_filename, presence: true
end
