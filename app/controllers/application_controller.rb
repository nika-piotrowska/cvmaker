class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  check_authorization unless: :devise_controller?

  def current_ability
    @current_ability ||= current_user&.ability
  end
end
