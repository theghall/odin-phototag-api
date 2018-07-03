require 'test_helper'

class LeaderboardAPIPostTestTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
    @appid = challenges(:challenge1).appid
  end

  test "it should not add a record for an invalid appid" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "f6a2598cb997d233"), 
      params: { player: { name: "John", challenge_time: "5.5" } } 
    assert_response(404)
  end

  test "it should not add a record for player with an improperly formatted name" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}"), 
        params: { player: { name: "Ogre(*", challenge_time: "5.5" } } 
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_match /name/i, json_resp[0]["errors"]
  end

  test "it should not add a record for player with an improperly formatted time" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}"), 
        params: { player: { name: "Ogre", challenge_time: "5.5A" } } 
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_match /challenge/i, json_resp[0]["errors"]
  end

  test "it should reject a request with no player param" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_match /missing/i, json_resp[0]["errors"]
  end

  test "it shoild reject a request with invalid params in player" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}"),
          params: { player: { name: "someone", challenge_time: "4.4", admin: "admin" } }
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_match /unpermitted/i, json_resp[0]["errors"]
  end
  test "it should add a record for a valid appid" do
    num_recs = Leaderboard.count

    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}"), 
        params: { player: { name: "Ogre55", challenge_time: "5.5" } } 
    assert_response(201)
    assert_equal num_recs + 1, Leaderboard.count
  end
end
