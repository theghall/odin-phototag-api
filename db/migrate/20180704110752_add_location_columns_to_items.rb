class AddLocationColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :bottom_left_loc, :text
    add_column :items, :top_left_loc, :text
    add_column :items, :top_right_loc, :text
    add_column :items, :bottom_right_loc, :text
  end
end
