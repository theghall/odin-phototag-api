require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  def setup
    @token = api_keys(:accesstoken1)
  end

  test "it should not permit blank tokens" do
    @token.access_token = ''
    assert_not @token.valid?
  end

  test "it should not permit dupe tokens" do
    assert_raises(ActiveRecord::RecordNotUnique) do
      ApiKey.create(access_token: @token.access_token)
    end
  end
end
