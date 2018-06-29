require 'test_helper'

class PhotoAPIQueryTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
  end

  test "it should reject an invalid query term" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "admin" => "admin")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    assert_match /unpermitted/i, json_resp["errors"]

  end

  test "it should accept a valid query using term 'number'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "5")
    assert_response :success
  end

  test "it should  reject a number query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /number/i, json_resp["errors"]
  end

  test "it should reject an invalid  query using term 'number'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "5A")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /number/i, json_resp["errors"]
  end

  test "it should accept a valid query using term 'difficulty'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "easy")
    assert_response :success
  end

  test "it should  reject a difficulty query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /difficulty/i, json_resp["errors"]
  end

  test "it should reject an invalid  query using term 'difficulty'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "*easy(")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /difficulty/i, json_resp["errors"]
  end

  test "it should accept a valid query using term 'category'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "scifi")
    assert_response :success
  end

  test "it should  reject a category query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /category/i, json_resp["errors"]
  end

  test "it should reject an invalid  query using term 'category'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "*scifi(")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp["code"]
    refute_match /unpermitted/i, json_resp["errors"]
    assert_match /category/i, json_resp["errors"]
  end
end
