require 'test_helper'

class LeaderboardTest < ActiveSupport::TestCase
  def setup
    @leader = leaderboards(:player1)
  end

  test ("it should not permit a blank name") do
    @leader.name = ''
    assert_not @leader.valid?
  end
end
