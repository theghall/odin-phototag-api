class API::V1::PhotosController < ApplicationController
  include ApplicationHelper
  before_action :valid_params, :authorized
  
  def initialize
    @permitted_params = [:format, :APITOKEN, :category, :difficulty, :number, :image_filename]
  end

  def index
    @photos = Photo.query(query_params(photo_params))
    render json: @photos, include: ['items']
  end

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from(ActionController::ParameterMissing) do |pme|
    render json: missing_param(pme), status: :bad_request
  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: unpermitted_param(pme), status: :bad_request
  end

  private
  
    def photo_params
      params.permit(@permitted_params)
    end

    def valid_params
      api_request = Validate::PhotoRequests.new(params, @permitted_params)
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
      queries = %w[category difficulty number image_filename]
      query_params = queries  & params.keys
      query_hash = {}
      query_params.each do |param|
        query_hash[param] = params[param]
      end
      query_hash
    end
end
