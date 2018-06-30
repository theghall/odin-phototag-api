require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @loc1 = locations(:a_item_1_loc)
  end

  test "it should not permit blanks for bottom_left_loc" do
    @loc1.bottom_left_loc =''
    assert_not @loc1.valid?
  end

  test "it should not permit blanks for top_left_loc" do
    @loc1.top_left_loc =''
    assert_not @loc1.valid?
  end

  test "it should not permit blanks for top_right_loc" do
    @loc1.top_right_loc = ''
    assert_not @loc1.valid?
  end

  test "it should not permit blanks for bottom_right_loc" do
    @loc1.bottom_right_loc = ''
    assert_not @loc1.valid?
  end
end
