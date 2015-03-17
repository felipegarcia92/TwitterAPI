module Api
  module V1
    class APIController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def authenticate_user
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        @current_user ||= User.find_by(session_token: params[:token])
      end

      def render_unauthorized
        render plain: "401 Authenticate Exception", status: 401
      end

      def record_not_found
        render plain: "Could not find a user with id: #{params[:id]}", status: 404
      end

    end
  end
end
