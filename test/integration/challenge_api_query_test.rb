require 'test_helper'

class ChallengeAPIQueryTestTest < ActionDispatch::IntegrationTest
  def setup
    @valid_token = access_tokens(:accesstoken1)
    @challenge = challenges(:challenge1)
  end

  test "it should reject invalid param" do
    get api_v1_challenges_url("APITOKEN" => "#{@valid_token.token}", "admin" => "admin")
    assert_response(400)
    json_resp = JSON.parse(response.body)
    assert_equal "400", json_resp[0]["code"]
    assert_match /unpermitted/i, json_resp[0]["errors"]
  end

  test "it should return a list of challenges" do
    get api_v1_challenges_url("APITOKEN" => "#{@valid_token.token}")
    assert_response(200)
    json_resp = JSON.parse(response.body)
    assert_equal @valid_token.challenges.count, json_resp.length
    assert_match @challenge.appid, json_resp[0]["appid"]
    assert_match @challenge.name, json_resp[0]["name"]
    assert_match @challenge.desc, json_resp[0]["desc"]
    assert_match @challenge.photo_name, json_resp[0]["photo_name"]
    # meta_data can be null, but checking serializer here
    assert_match @challenge.meta_data, json_resp[0]["meta_data"]
  end
end

