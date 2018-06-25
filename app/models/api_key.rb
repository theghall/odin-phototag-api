class ApiKey < ApplicationRecord
  validates :access_token, presence: true
end
