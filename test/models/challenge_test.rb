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

  test "it should return no record on non-existent appid" do
    assert_nil Challenge.query({"appid" => "1677246761aa79da"})
  end

  test "it should return a record on an existent apppid" do
    refute_nil Challenge.query({"appid" => "#{@challenge.appid}"})
  end

  test "it should return nil on a nonexistent appid" do
    assert_nil Challenge.get_id({"appid" => "1234"})
  end

  test "it should return a record with the correct id" do
    assert_equal @challenge.id, Challenge.get_id({"appid" => "#{@challenge.appid}"})
  end
end