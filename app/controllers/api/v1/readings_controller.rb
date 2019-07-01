class Api::V1::ReadingsController < ApplicationController
  before_action :authenticate_thermostat

  def create
    sequence_number = Reading.next_seq

    ReadingUpdaterWorker.perform_async(current_thermostat.id, reading_params.to_json, sequence_number)

    render json: {reading_sequence_number: sequence_number}
  end

  def show
    reading_sequence_number = params[:id].to_i
    reading = current_thermostat.readings.where(number: params[:id]).first

    unless reading
      queue = Sidekiq::Queue.new("reading_updater_worker")
      reading = queue.detect { |job| job.args[0] == current_thermostat.id && job.args[2] == reading_sequence_number }
      reading = Reading.new(JSON.parse(reading.args[1]).symbolize_keys())
    end

    unless reading
      render_error(404)
    else
      render json: reading
    end
  end

  def stats
    render json: current_thermostat.stats
  end

  private
  def reading_params
    params.require(:reading).permit(:temperature, :humidity, :battery_charge)
  end

  def reading_sequence_number
    params.require
  end
end
