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
    attr_accessor :number, :difficulty, :category

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

    def initialize(params={})
      super(params)
      @number = number_or_nil(params[:number])
      @difficulty = params[:difficulty]
      @category = params[:category]
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(:format, :APITOKEN, :number, :difficulty, :category)
    end

  end

  class LeaderboardGetRequests < BaseRequests
    include ApplicationHelper, ActiveModel::Validations

    attr_accessor :appid

    validate :is_alphanumeric_appid
    validates :appid, presence: true, length: { is: 16 }

    def initialize(params={})
      super(params)
      @appid = params[:appid]
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(:format, :APITOKEN, :appid)
    end

    private

      def is_alphanumeric_appid
        if !is_alphanumeric_token?(@appid)
          errors.add(:appid, invalid_token())
        end
      end
  end

  class LeaderboardPostRequests < BaseRequests
    include ApplicationHelper, ActiveModel::Validations

    attr_accessor :appid, :name, :challenge_time

    validate :is_alphanumeric_appid
    validates :appid, presence: true, length: { is: 16 }
    validates :name, presence: true, format: { with: /\A[a-z]+[0-9]*\z/i,  message: "can only be letters followed by numbers" }
    validates :challenge_time, presence: true, numericality: true

    def initialize(params={})
      super(params)
      @appid = params[:appid]
      if !params[:player].nil?
        @name = params[:player][:name]
        @challenge_time = params[:player][:challenge_time]
      end
      ActionController::Parameters.new(JSON.parse(params.to_json)).require(:player).permit(:format, :APITOKEN, :appid, :name, :challenge_time)
    end

    private

      def is_alphanumeric_appid
        if !is_alphanumeric_token?(@appid)
          errors.add(:appid, invalid_token())
        end
      end
  end
end
