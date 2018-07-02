require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  def setup
    @challenge = challenges(:challenge1)
  end

  test "it should not allow blank name" do
    @challenge.name = ''
    assert_not @challenge.valid?
  end

  test "it should not allow blank desc" do
    @challenge.desc = ''
    assert_not @challenge.valid?
  end
end
