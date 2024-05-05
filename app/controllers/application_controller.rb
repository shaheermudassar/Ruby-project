# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name phone email password current_password])
  end

  def user_not_authorized
    # self.response_body = nil
    flash[:alert] = t(:authorize_fail)
    redirect_to root_path
  end
#when a user have to add article ,delete article then he should be login 
  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:alert] = t(:user_not_logged_in)
      redirect_to new_user_session_path
    end
  end

  def record_not_found
    flash.now[:alert] = t(:not_found_record)
    render file: Rails.public_path.join('404.html'), status: :not_found
  end
end
