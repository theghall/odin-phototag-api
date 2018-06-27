module ApplicationHelper
  def valid_token?(token) 
    AccessToken.find_token(token) != nil
  end

  def unauth_string
    '{"code": "401", "message": "Invalid API Token"}'
  end
end
