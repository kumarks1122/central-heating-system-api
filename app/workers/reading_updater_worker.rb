class ReadingUpdaterWorker
  include Sidekiq::Worker

  sidekiq_options queue: "reading_updater_worker", backtrace: true

  def perform(thermostat_id, reading_params, sequence_number)
    reading_params = JSON.parse(reading_params)
    thermostat = Thermostat.find(thermostat_id)
    reading = thermostat.readings.new
    reading.temperature = reading_params["temperature"]
    reading.humidity = reading_params["humidity"]
    reading.battery_charge = reading_params["battery_charge"]
    reading.number = sequence_number
    reading.save
  end
end
