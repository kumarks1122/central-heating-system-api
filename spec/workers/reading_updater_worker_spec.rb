require 'rails_helper'
RSpec.describe ReadingUpdaterWorker, type: :worker do
  describe ".perform" do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    let(:params) { {temperature: 24.5, humidity: 34.5, battery_charge: 20.5} }
    let(:sequence_number) { Reading.next_seq }
    let(:worker) { ReadingUpdaterWorker.new }
    
    it "creates reading for thermostats" do
      worker.perform(thermostat.id, params.to_json, sequence_number)
      expect(thermostat.readings.size).to eql 1
    end
  end
end
