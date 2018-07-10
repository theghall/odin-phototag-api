class API::V1::ChallengesController < ApplicationController
  include ApplicationHelper
  before_action :valid_params, :authorized

  def initialize
    @permitted_params = [:format, :APITOKEN]
  end

  def index

    @access_token = AccessToken.find_token(challenge_params[:APITOKEN]);
    @challenges = @access_token.challenges
    render json: @challenges
  end

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from(ActionController::ParameterMissing) do |pme|
    render json: missing_param(pme), status: :bad_request
  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: unpermitted_param(pme), status: :bad_request
  end

  private
    def challenge_params
      params.permit(@permitted_params)
    end

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
