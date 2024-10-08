# frozen_string_literal: true

module API
  module V1
    class UsersController < API::V1::APIController
      def show
        authorize current_user
      end

      def update
        authorize current_user
        current_user.update!(update_user_params)
        render :update
      end

      private

      def update_user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email).merge(updated_at: 2.days.before)
      end
    end
  end
end
