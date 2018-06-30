require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = items(:a_item_1)
  end

  test ("It should not permit a blank name") do
    @item.name = '';
    assert_not @item.valid?
  end
end
