class API::V1::PhotosController < ApplicationController
  include ApplicationHelper
  before_action :valid_params, :authorized

  def index
  end

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from(ActionController::ParameterMissing) do |pme|
    render json: missing_param(pme), status: :bad_request
  end

  private
  
    def valid_params
      api_request = Validate::PhotoRequests.new(params)
      if !api_request.valid?
        render json: param_error(api_request), status: :bad_request
      end
    end

    def authorized
      if (!valid_token?(params["APITOKEN"]))
        render json: unauth_string, status: :unauthorized
      end
    end
end
