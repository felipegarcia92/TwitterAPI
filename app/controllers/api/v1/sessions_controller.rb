require 'digest/sha1'

module Api
  module V1
    class SessionsController < APIController
      skip_before_action :authenticate_user!, only: :login

      def login
        user = User.find_by(email: params[:email])
        if (user && (user.encrypted_password == Digest::SHA1.hexdigest(params[:password])))
          user.set_session_token
          user.save

          render json: user.session_token, status: :ok
        else
          render json: "Authentication error", status: 401
        end
      end

    end
  end
end
