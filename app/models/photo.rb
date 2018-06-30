class Photo < ApplicationRecord
  has_many :items
  default_scope -> { order(name: :asc) }

  validates :name, presence: true
  validates :desc, presence: true
  validates :difficulty, presence: true
  validates :category, presence: true
  validates :image_filename, presence: true

  def self.query(query_params)
    number = query_params.delete("number")
    number = number.to_i unless number.nil?

    if query_params.keys.empty? && number.nil?
      return Photo.all
    elsif query_params.empty? && !number.nil?
      return Photo.all.limit(number)
    elsif !query_params.keys.empty? && !number.nil?
      return where(query_params).limit(number)
    elsif !query_params.keys.empty? && number.nil?
      return where(query_params)
    end
  end
end
