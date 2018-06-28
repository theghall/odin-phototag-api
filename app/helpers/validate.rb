module Validate
  class PhotoRequests
    include ActiveModel::Validations
    attr_accessor :APITOKEN

    validate :is_alphanumeric_token
    validates :APITOKEN, presence: true, length: { is: 32 }

    def initialize(params={})
      @APITOKEN = params[:APITOKEN]
      ActionController::Parameters.new(JSON.parse(params.to_json)).require(:APITOKEN)
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
