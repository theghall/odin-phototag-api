module Validate
  class BaseRequests
    include ApplicationHelper, ActiveModel::Validations
    attr_accessor :params, :APITOKEN

    validate :is_alphanumeric_api_token
    validates :APITOKEN, presence: true, length: { is: 32 }

    def initialize(params)
      @params = params
      @APITOKEN = params[:APITOKEN]
    end

    private
      def invalid_token
        "must contain letters and numbers only"
      end

      def is_alphanumeric_token?(token)
        valid = true
        match = /^[a-z0-9]+$/.match(token)
        if match.nil? || match.string != token
          valid = false
        end
        valid
      end


      def is_alphanumeric_api_token
        if !is_alphanumeric_token?(@APITOKEN)
          errors.add(:APITOKEN, invalid_token())
        end
      end
  end

  class PhotoRequests < BaseRequests
    include ApplicationHelper, ActiveModel::Validations
    attr_accessor :number, :difficulty, :category, :image_filename

    # Below validations are for optional parameters
    # TODO: find out how to make if: :optional_present?(param) work
    validates :number, presence: true,
              numericality: { only_integer: true },
              if: Proc.new { |o| o.params.include?(:number) }
    validates :difficulty, presence: true,
              format: { with: /\A[a-z]+\z/i,  message: "must be all letters" },
              if: Proc.new { |o| o.params.include?(:difficulty) }
    validates :category, presence: true,
              format: { with: /\A[a-z]+\z/i,  message: "must be all letters" },
              if: Proc.new { |o| o.params.include?(:category) }
    validates :image_filename, presence: true,
              format: { with: /\A[a-z]+[0-9]*\.jpg|png\z/i, message: "invalid filename" },
              if: Proc.new { |o| o.params.include?(:image_filename) }

    def initialize(params, permitted_params)
      super(params)
      @number = number_or_nil(params[:number])
      @difficulty = params[:difficulty]
      @category = params[:category]
      @image_filename = params[:image_filename]
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(permitted_params)
    end

  end

  class ChallengeRequests < BaseRequests
    def initialize(params, permitted_params)
      super(params)
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(permitted_params)
    end
  end

  class LeaderboardBaseRequests < BaseRequests
    include ApplicationHelper, ActiveModel::Validations

    attr_accessor :appid

    validate :is_alphanumeric_appid
    validates :appid, presence: true, length: { is: 16 }

    def initialize(params)
      super(params)
      @appid = params[:appid]
    end

    private

      def is_alphanumeric_appid
        if !is_alphanumeric_token?(@appid)
          errors.add(:appid, invalid_token())
        end
      end

  end

  class LeaderboardGetRequests < LeaderboardBaseRequests
    include ApplicationHelper, ActiveModel::Validations

    def initialize(params, permitted_params)
      super(params)
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(permitted_params)
    end
  end

  class LeaderboardPostRequests < LeaderboardBaseRequests
    include ApplicationHelper, ActiveModel::Validations

    attr_accessor :name, :challenge_time

    validates :name, presence: true, format: { with: /\A[a-z]+[0-9]*\z/i,  message: "can only be letters followed by numbers" }
    validates :challenge_time, presence: true, numericality: true

    def initialize(params, permitted_params)
      super(params)
      # Cause ActionController::ParameterMissing to be raised
      leader = params.fetch(:leaderboard)
      @name = leader.fetch(:name)
      @challenge_time = leader.fetch(:challenge_time)
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(permitted_params)
    end
  end
end
