require 'test_helper'

class LeaderboardAPIAuthTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
    @appid = challenges(:challenge1).appid
  end

  test "it should reject an API request with no APITOKEN query on a get" do
    get api_v1_leaderboards_url("appid" => "#{@appid}")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /apitoken/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with an empty token on a get" do
    get api_v1_leaderboards_url("APITOKEN" => "", "appid" => "#{@appid}")
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /apitoken/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with a token of invalid length on a get" do
    get api_v1_leaderboards_url("APITOKEN" => "1a1a1", "appid" => "#{@appid}")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /length/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with a token of invalid format on a get" do
    get api_v1_leaderboards_url("APITOKEN" => "1a1(1a1a1a1*1a1a1;1a1a1a1a1a1a1a", "appid" => "#{@appid}")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /contain/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with an unauthorized token on a get" do
    get api_v1_leaderboards_url("APITOKEN" => "1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a", "appid" => "#{@appid}")
    assert_response(401)
    json_resp = JSON.parse(response.body)
    assert_equal "401", json_resp[0]["code"]
    assert_match /invalid/i, json_resp[0]["errors"]
  end

  test "it should accept a valid token on a get" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}")
    assert_response :success
  end

  test "it should reject an API request with no APITOKEN query on a post" do
    post api_v1_leaderboards_url("appid" => "#{@appid}"), params: { leaderboard: { name: "someone", challenge_time: "4.4" } }
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /apitoken/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with an empty token on a post" do
    post api_v1_leaderboards_url("APITOKEN" => "", "appid" => "#{@appid}"), params: { leaderboard: { name: "someone", challenge_time: "4.4" } }
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /apitoken/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with a token of invalid length on a post" do
    post api_v1_leaderboards_url("APITOKEN" => "1a1a1", "appid" => "#{@appid}"), params: { leaderboard: { name: "someone", challenge_time: "4.4" } }
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /length/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with a token of invalid format on a post" do
    post api_v1_leaderboards_url("APITOKEN" => "1a1(1a1a1a1*1a1a1;1a1a1a1a1a1a1a", "appid" => "#{@appid}"),
      params: { leaderboard: { name: "someone", challenge_time: "4.4" } }
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /contain/i, json_resp[0]["errors"]
  end

  test "it should reject an API request with an unauthorized token on a post" do
    post api_v1_leaderboards_url("APITOKEN" => "1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a", "appid" => "#{@appid}"),
      params: { leaderboard: { name: "someone", challenge_time: "4.4" } }
    assert_response(401)
    json_resp = JSON.parse(response.body)
    assert_equal "401", json_resp[0]["code"]
    assert_match /invalid/i, json_resp[0]["errors"]
  end

  test "it should accept a valid token on a post" do
    post api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@appid}"),
      params: { leaderboard: { name: "someoneelse", challenge_time: "4.4" } }
    assert_response :success
  end

end
