require 'test_helper'

class AccessTokenTest < ActiveSupport::TestCase
  def setup
    @token = access_tokens(:accesstoken1)
  end

  test "it should not permit blank tokens" do
    @token.token = ''
    assert_not @token.valid?
  end

  test "it should not permit dupe tokens" do
    assert_raises(ActiveRecord::RecordNotUnique) do
      AccessToken.create(token: @token.token)
    end
  end

  test "it should find valid token" do
    assert_equal @token.token, AccessToken.find_token(@token.token).token
  end

  test "it shoud return nil for invalid token" do
    assert_nil AccessToken.find_token('invalid')
  end
end
