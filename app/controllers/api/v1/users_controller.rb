module Api
  module V1
    class UsersController < APIController
      def show
        #user = User.find(params[:id])
        if @current_user
          render json: @current_user, status: :ok
        end
      end

    end
  end
end
