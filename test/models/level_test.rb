require 'test_helper'

class LevelTest < ActiveSupport::TestCase
  def setup
    @player1_easy = levels(:player1_easy)
  end

  test "it should not allow a blank difficulty" do
    @player1_easy.difficulty = ''
    assert_not @player1_easy.valid?
  end

  test "it should not permit a bank best time" do
    @player1_easy.best_time = ''
    assert_not @player1_easy.valid?
  end
end
