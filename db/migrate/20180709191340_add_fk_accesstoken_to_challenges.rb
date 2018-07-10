class AddFkAccesstokenToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_reference :challenges, :access_token, foreign_key: true
  end
end
