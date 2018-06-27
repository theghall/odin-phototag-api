require 'test_helper'


class PhotoAPITest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
  end

  test "it should reject an API request with no token" do
    get api_v1_photos_url
    assert_response(401)
    json_resp = JSON.parse(response.body)
    assert_equal "401", json_resp["code"]
    assert_match /invalid/i, json_resp["message"]
  end

  test "it should reject an API request with an invalid token" do
    get api_v1_photos_url("APITOKEN=invalid")
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
