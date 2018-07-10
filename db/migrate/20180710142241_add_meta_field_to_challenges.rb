class AddMetaFieldToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :meta_data, :string
  end
end
