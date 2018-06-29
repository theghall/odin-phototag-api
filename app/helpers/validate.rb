module Validate
  class PhotoRequests
    include ApplicationHelper, ActiveModel::Validations
    attr_accessor :params, :APITOKEN, :number, :difficulty, :category

    validate :is_alphanumeric_token
    validates :APITOKEN, presence: true, length: { is: 32 }
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
      @params = params
      @APITOKEN = params[:APITOKEN]
      @number = number_or_nil(params[:number])
      @difficulty = params[:difficulty]
      @category = params[:category]
      ActionController::Parameters.new(JSON.parse(params.to_json)).permit(:format, :APITOKEN, :number, :difficulty, :category)
    end

    private

      def is_alphanumeric_token
        match = /^[a-z0-9]+$/.match(@APITOKEN)
        if match.nil? || match.string != @APITOKEN
          errors.add(:APITOKEN, "must contain letters and numbers only")
        end
      end
  end
end
