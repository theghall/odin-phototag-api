require 'test_helper'

class LeaderboardAPIQueryTestTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
    @challenge = challenges(:challenge1)
  end

  test "it should reject invalid param" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "admin" => "admin")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /unpermitted/i, json_resp[0]["errors"]
  end

  test "it should reject an 'appid' query with no value" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /appid/i, json_resp[0]["errors"]

  end

  test "it should reject an 'appid' query having wrong length" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "1a1a")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /appid/i, json_resp[0]["errors"]
  end

  test "it should reject an 'appid' query having invalid format" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "1a1a(a1a1a1*1a1a")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /appid/i, json_resp[0]["errors"]
  end

  test "it should return no records for a non-existant 'appid'" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "1a1a1a1a1a1a1a1a")
    assert_response(404)
    json_resp = JSON.parse(response.body)
    assert_equal "404", json_resp[0]["code"]
    assert_match /not found/i, json_resp[0]["errors"]
  end

  test "it should return correct fields" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@challenge.appid}")
    assert_response(200)
    json_resp = JSON.parse(response.body)
    refute_nil json_resp[0]["name"]
    refute_nil json_resp[1]["challenge_time"]
  end


  test "it should return correct records for an existant 'appid'" do
    get api_v1_leaderboards_url("APITOKEN" => "#{@valid_token.token}", "appid" => "#{@challenge.appid}")
    assert_response(200)
    json_resp = JSON.parse(response.body)
    assert_match "Jane", json_resp[0]["name"]
    assert_match "Troll", json_resp[1]["name"]
  end

end
