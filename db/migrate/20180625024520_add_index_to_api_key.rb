class AddIndexToAPIKey < ActiveRecord::Migration[5.2]
  def change
    add_index :api_keys, :access_token, unique: true
  end
end
