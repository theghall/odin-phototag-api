module ApplicationHelper
  def valid_token?(token) 
    AccessToken.find_token(token) != nil
  end

  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
     nil
  end

  def unauth_string
    {"code"  => "401", "message" => "Invalid API Token"}
  end

  def param_error(pme)
    {"code" => "#{Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]}", "errors" => "#{pme.errors.full_messages}"}
  end

  def missing_param(pme)
    {"code" => "#{Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]}", "message" => "missing params: #{pme.param}"}
  end

  def unpermitted_param(pme)
    {"code" => "#{Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request]}", "errors" => "#{pme.message}"}
  end
end
