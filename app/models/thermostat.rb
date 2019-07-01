class Thermostat < ApplicationRecord
  has_many :readings

  before_create :set_household_token

  def stats
    result = {}
    queue = Sidekiq::Queue.new("reading_updater_worker")
    sidekiq_reading = queue.select { |job| job.args[0] == id }
    sidekiq_reading = sidekiq_reading.map { |x| Reading.new(JSON.parse(x.args[1]).symbolize_keys()) }

    readings_arr = readings.to_a + sidekiq_reading

    unless readings_arr[0].nil?
      [:humidity, :temperature, :battery_charge].each do |reading_field|
        result[reading_field] = {}
        result[reading_field][:minimum] = readings_arr.min_by(&reading_field)[reading_field]
        result[reading_field][:maximum] = readings_arr.max_by(&reading_field)[reading_field]
        result[reading_field][:average] = readings_arr.inject(0){ |sum, el| sum + el[reading_field] }.to_f / readings_arr.size
      end
    end

    result
  end

  private
  def set_household_token
    self.household_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.base58(80)
      break token unless Thermostat.where(household_token: token).exists?
    end
  end
end
