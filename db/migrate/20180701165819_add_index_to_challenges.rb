class AddIndexToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_index :challenges, :name
  end
end
