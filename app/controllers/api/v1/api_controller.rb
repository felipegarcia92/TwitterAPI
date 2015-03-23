module Api
  module V1
    class APIController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def record_not_found
        render json: "Could not find a user with id: #{params[:id]}", status: 404
      end

      def record_invalid
        render json: "Record Invalid", status: 422
      end

      def parameter_missing
        render json: "422 Parameter Missing", status: 422
      end

    end
  end
end
