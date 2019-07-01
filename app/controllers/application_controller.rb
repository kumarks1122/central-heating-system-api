class ApplicationController < ActionController::Base
  helper_method :authenticate_thermostat, :current_thermostat, :render_error
  skip_before_action :verify_authenticity_token

  def authenticate_thermostat
    unless current_thermostat
      render_error(401)
      return false
    end

    return true
  end

  def current_thermostat
    thermostat = AuthManager.new(request.headers['Authorization']).current_thermostat
    return thermostat
  end

  def render_error(error_code=400)
    render :json=> {:message=>'Error'},:status=>error_code
  end
end
