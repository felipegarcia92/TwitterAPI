module Api
  module V1
    class APIController < ApplicationController
      before_action :authenticate_user

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def authenticate_user
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        @current_user = User.find_by(session_token: params[:token])
      end

      def render_unauthorized
        render json: "401 Authenticate Exception", status: 401
      end

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
