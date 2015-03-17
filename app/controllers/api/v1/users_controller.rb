module Api
  module V1
    class UsersController < APIController
      before_action :authenticate_user

      def show
        #user = User.find(params[:id])
        if @current_user
          render json: @current_user, status: :ok
        else
          raise "User not found"
        end
      end

    end
  end
end
