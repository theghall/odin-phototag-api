class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.text :access_token

      t.timestamps
    end
  end
end
