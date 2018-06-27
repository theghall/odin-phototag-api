class AccessToken < ApplicationRecord
  validates :token, presence: true

  def self.find_token(token)
    where(:token => token).first
  end
end
