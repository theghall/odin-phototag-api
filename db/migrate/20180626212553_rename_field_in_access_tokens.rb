class RenameFieldInAccessTokens < ActiveRecord::Migration[5.2]
  def change
    rename_column :access_tokens, :access_token, :token
  end
end
