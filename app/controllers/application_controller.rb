class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_ability
    @current_ability ||= current_user&.ability
  end
end
