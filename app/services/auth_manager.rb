class AuthManager
  attr_accessor :token

  def initialize(token="")
    @token = token
  end

  # get current Thermostat
  def current_thermostat
    return Thermostat.where(household_token: token).first
  end
end