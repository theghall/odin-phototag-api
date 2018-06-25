class Item < ApplicationRecord
  belongs_to :photo
  has_many :locations

  validates :name, presence: true
end
