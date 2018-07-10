class AddPhotoNameToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :photo_name, :text
  end
end
