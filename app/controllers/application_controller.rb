class ApplicationController < ActionController::Base
  # Disable CSRF protection (already in your app)
  skip_forgery_protection

  # Permit additional parameters for Devise during sign-up and account update
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit the new fields during sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :image, :bio])

    # Permit the new fields during account update (if needed)
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :image, :bio])
  end
end
