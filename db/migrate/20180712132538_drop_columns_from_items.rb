class DropColumnsFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :bottom_left_loc
    remove_column :items, :top_right_loc
  end
end
