# frozen_string_literal: true

module API
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      include API::Concerns::ActAsAPIRequest
      protect_from_forgery with: :null_session

      private

      # rubocop:disable Metrics/AbcSize
      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation,
                                     :username, :first_name, :last_name).tap do |p|
          if params[:user][:admin_email].blank? == false
            admin_user = AdminUser.find_by(email: params[:user][:admin_email])
            p[:added_by_id] = admin_user.id if admin_user.blank? == false
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      def render_create_success
        render :create
      end

      def render_error(status, message, _data = nil)
        render json: { errors: Array.wrap(message:) }, status:
      end
    end
  end
end
