class API::V1::ChallengesController < ApplicationController
  include ApplicationHelper
  before_action :valid_params, :authorized

  def initialize
    @permitted_params = [:format, :APITOKEN]
  end

  def index

  end

  private

    def valid_params
      api_request = Validate::ChallengeRequests.new(params, @permitted_params)
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
