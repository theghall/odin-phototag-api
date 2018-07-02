require 'test_helper'

class LeaderboardTest < ActiveSupport::TestCase
  def setup
    @challenge1 = challenges(:challenge1)
    @leader = leaderboards(:player1_challenge1)
  end

  test "it should not permit a blank name" do
    @leader.name = ''
    assert_not @leader.valid?
  end

  test "it should not permit a blank time" do
    @leader.best_time = ''
    assert_not @leader.valid?
  end

  test "it should only permit numbers for best_time" do
    @leader.best_time = "5a"
    assert_not @leader.valid?
  end

  test "it should not permit a blank challenge_id" do
    @leader.challenge_id = ''
    assert_not @leader.valid?
  end

  test "it should permit a player in two challenges" do
    num_leader_recs = Leaderboard.count
    c1 = Challenge.create(name: "yyyyy", desc: "something")
    c1.leaderboards.build(name: "John", best_time: 13).save
    assert_equal num_leader_recs + 1, Leaderboard.count 
    c2 = Challenge.create(name: "zzzzz", desc: "something")
    c2.leaderboards.build(name: "John", best_time: 12).save
    assert_equal num_leader_recs + 2, Leaderboard.count 
  end

  test "it should not permit a duplicate player in a challenge" do
    assert_raises ActiveRecord::RecordNotUnique do
      @challenge1.leaderboards.build(name: @leader.name, best_time: 5).save
    end
  end

end
