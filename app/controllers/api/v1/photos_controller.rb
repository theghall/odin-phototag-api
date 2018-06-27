class API::V1::PhotosController < ApplicationController
  include ApplicationHelper
  before_action :authorized

  def index
  end

  private

    def authorized
      if (!valid_token?(params["APITOKEN"]))
        render json: unauth_string, status: :unauthorized
      end
    end
end
