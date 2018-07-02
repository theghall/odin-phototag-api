class API::V1::LeaderboardsController < ApplicationController
  include ApplicationHelper
  before_action :valid_params, :authorized

  def index

  end

  def create

  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: unpermitted_param(pme), status: :bad_request
  end

  private

    def valid_params
      api_request = Validate::LeaderboardRequests.new(params)
      if !api_request.valid?
        render json: param_error(api_request), status: :bad_request
      end
    end

    def authorized
      if (!valid_token?(params["APITOKEN"]))
        render json: unauth_string(), status: :unauthorized
      end
    end
end
