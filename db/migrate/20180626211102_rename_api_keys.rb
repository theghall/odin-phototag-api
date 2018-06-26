class RenameAPIKeys < ActiveRecord::Migration[5.2]
  def change
    rename_table :api_keys, :access_tokens
  end
end
