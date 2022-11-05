class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  check_authorization unless: :devise_controller?

  def current_ability
    @current_ability ||= current_user&.ability
  end

  private

  def assure_end_date_format(permited_params, current_end_date)
    month = permited_params[:"end_date(2i)"]
    year = permited_params[:"end_date(1i)"]
    if current_end_date.nil?
      permited_params[:"end_date(2i)"] = '1' if month.empty? && year.present?
      permited_params[:"end_date(1i)"] = (Date.today.year - 50).to_s if year.empty? && month.present?
    elsif year.empty? || month.empty?
      permited_params[:"end_date(2i)"] = ''
      permited_params[:"end_date(1i)"] = ''
    end
    permited_params
  end
end
