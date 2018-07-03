class API::V1::LeaderboardsController < ApplicationController
  include ApplicationHelper
  before_action :valid_get_params, only: [:index]
  before_action :valid_post_params, only: [:create]
  before_action :authorized

  def index
    @leaderboard = Leaderboard.query(query_params(params))

    if @leaderboard.empty?
      render json: not_found(), status: :not_found
    else
      render json: @leaderboard
    end
  end

  def create
    @challenge = Challenge.query(query_params(params))

    if @challenge.nil?
      render json: not_found(), status: :not_found
    else
      @leader = @challenge.leaderboards.build(post_params)

      if @leader.save
        head :created
      else
        head :internal_server_error
      end
    end
  end

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from(ActionController::ParameterMissing) do |pme|
    render json: missing_param(pme), status: :bad_request
  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: unpermitted_param(pme), status: :bad_request
  end

  private

    def post_params
      params.require(:player).permit(:name, :challenge_time)
    end

    def valid_get_params
      api_request = Validate::LeaderboardGetRequests.new(params)
      if !api_request.valid?
        render json: param_error(api_request), status: :bad_request
      end
    end

    def valid_post_params
      api_request = Validate::LeaderboardPostRequests.new(params)
      if !api_request.valid?
        render json: param_error(api_request), status: :bad_request
      end
    end

    def authorized
      if (!valid_token?(params["APITOKEN"]))
        render json: unauth_string(), status: :unauthorized
      end
    end

    def query_params(params)
      queries = %w[appid]
      query_params = queries  & params.keys
      query_hash = {}
      query_params.each do |param|
        query_hash[param] = params[param]
      end
      query_hash
    end
end
