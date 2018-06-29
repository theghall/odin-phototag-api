require 'test_helper'


class PhotoAPIAuthTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
  end

  test "it should reject an API request with no APITOKEN query" do
    get api_v1_photos_url
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    assert_match /apitoken/i, json_resp["errors"]
  end

  test "it should reject an API request with an empty token" do
    get api_v1_photos_url("APITOKEN" => "")
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    assert_match /apitoken/i, json_resp["errors"]
  end

  test "it should reject an API request with a token of invalid length" do
    get api_v1_photos_url("APITOKEN" => "1a1a1")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    assert_match /length/i, json_resp["errors"]
  end

  test "it should reject an API request with a token of invalid format" do
    get api_v1_photos_url("APITOKEN" => "1a1(1a1a1a1*1a1a1;1a1a1a1a1a1a1a")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    assert_match /contain/i, json_resp["errors"]
  end

  test "it should reject an API request with an unauthorized token" do
    get api_v1_photos_url("APITOKEN" => "1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a")
    assert_response(401)
    json_resp = JSON.parse(response.body)
    assert_equal "401", json_resp["code"]
    assert_match /invalid/i, json_resp["message"]
  end

  test "it should accept a valid token" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}")
    assert_response :success
  end
end
