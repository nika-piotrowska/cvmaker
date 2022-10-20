class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  check_authorization unless: :devise_controller?

  def current_ability
    @current_ability ||= current_user&.ability
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end
end
