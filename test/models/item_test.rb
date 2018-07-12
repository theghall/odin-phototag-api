require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = items(:a_item_1)
  end

  test ("It should not permit a blank name") do
    @item.name = '';
    assert_not @item.valid?
  end

  test "it should not permit blanks for top_left_loc" do
    @item.top_left_loc =''
    assert_not @item.valid?
  end

  test "it should not permit blanks for bottom_right_loc" do
    @item.bottom_right_loc = ''
    assert_not @item.valid?
  end
end
