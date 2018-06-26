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
end
