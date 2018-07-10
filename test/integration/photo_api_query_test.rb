require 'test_helper'

class PhotoAPIQueryTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
    @photo = Photo.second
  end

  test "it should reject an invalid query term" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "admin" => "admin")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /unpermitted/i, json_resp[0]["errors"]

  end

  test "it should accept a valid query using term 'number'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "5")
    assert_response :success
  end

  test "it should  reject a number query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /number/i, json_resp[0]["errors"]
  end

  test "it should reject an invalid  query using term 'number'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "5A")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /number/i, json_resp[0]["errors"]
  end

  test "it should accept a valid query using term 'difficulty'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "easy")
    assert_response :success
  end

  test "it should  reject a difficulty query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /difficulty/i, json_resp[0]["errors"]
  end

  test "it should reject an invalid  query using term 'difficulty'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "*easy(")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /difficulty/i, json_resp[0]["errors"]
  end

  test "it should accept a valid query using term 'category'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "catone")
    assert_response :success
  end

  test "it should  reject a category query with no value" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /category/i, json_resp[0]["errors"]
  end

  test "it should reject an invalid  query using term 'category'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "*catone(")
    assert_response :bad_request
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    refute_match /unpermitted/i, json_resp[0]["errors"]
    assert_match /category/i, json_resp[0]["errors"]
  end

  test "it should return all records" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}")
    json_resp = JSON.parse(response.body)
    assert_equal Photo.count, json_resp.length
  end

  test "it should return one record" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "1")
    json_resp = JSON.parse(response.body)
    assert_equal 1, json_resp.length
  end

  test "it should return all fields" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "number" => "1")
    json_resp = JSON.parse(response.body)
    assert_equal "aaaaa", json_resp[0]["name"]
    assert_equal "a test", json_resp[0]["desc"]
    assert_equal "catone", json_resp[0]["category"]
    assert_equal "aaaaa.png", json_resp[0]["image_filename"]
    assert_equal "a_item_1", json_resp[0]["items"][0]["name"]
    assert_equal "1,2", json_resp[0]["items"][0]["bottom_left_loc"]
    assert_equal "1,3", json_resp[0]["items"][0]["top_left_loc"]
    assert_equal "3,4", json_resp[0]["items"][0]["top_right_loc"]
    assert_equal "1,4", json_resp[0]["items"][0]["bottom_right_loc"]
    assert_equal "a_item_2", json_resp[0]["items"][1]["name"]
  end

  test "it should return all records with category 'catone'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "catone")
    json_resp = JSON.parse(response.body)
    assert_equal 3, json_resp.length
    json_resp.each do |record|
      assert_equal "catone", record["category"]
    end
  end

  test "it should return all records with category 'catone' and category 'hard'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "catone", "difficulty" => "hard")
    json_resp = JSON.parse(response.body)
    assert_equal 2, json_resp.length
    json_resp.each do |record|
      assert_equal "catone", record["category"]
      assert_equal "hard", record["difficulty"]
    end
  end

  test "it should return all records with category 'cattwo' and difficulty 'easy' and number '1'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "category" => "cattwo", "difficulty" => "easy", "number" => "1")
    json_resp = JSON.parse(response.body)
    assert_equal 1, json_resp.length
    json_resp.each do |record|
      assert_equal "cattwo", record["category"]
      assert_equal "easy", record["difficulty"]
    end
  end

  test "it should return all records with diffculty 'hard'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "hard")
    json_resp = JSON.parse(response.body)
    assert_equal 2, json_resp.length
    json_resp.each do |record|
      assert_equal "hard", record["difficulty"]
    end
  end

  test "it should return all records with diffculty 'hard' and number '1'" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "difficulty" => "hard", "number" => "1")
    json_resp = JSON.parse(response.body)
    assert_equal 1, json_resp.length
    json_resp.each do |record|
      assert_equal "hard", record["difficulty"]
    end
  end

  test "it should return photo record given photo name" do
    get api_v1_photos_url("APITOKEN" => "#{@valid_token.token}", "image_filename" => "#{@photo.image_filename}")
    json_resp = JSON.parse(response.body)
    assert_match @photo.image_filename, json_resp[0]["image_filename"]
  end
end
