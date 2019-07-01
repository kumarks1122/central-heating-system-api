require 'rails_helper'

RSpec.describe Api::V1::ReadingsController, type: :controller do

  context 'when household_token' do
    let(:thermostat) { FactoryBot.create(:thermostat) }
    let(:reading) { FactoryBot.create(:reading, thermostat: thermostat) }
    let(:sample_reading) { { temperature: 24.5, humidity: 34.5, battery_charge: 20.5 } }
    let(:headers) { { Authorization: thermostat.household_token } }

    context "is passed for" do
      it "Post Reading returns success response" do
        request.headers.merge! headers
        post :create, params: {reading: sample_reading}
        expect(response.response_code).to eql 200
      end

      it "Get Reading returns success response" do
        request.headers.merge! headers
        get :show, params: {id: reading.number}
        expect(response.response_code).to eql 200
      end

      it "Get Stats returns success response" do
        request.headers.merge! headers
        get :stats
        expect(response.response_code).to eql 200
      end
    end

    context "is not passed for" do
      it "Post Reading returns unauthorized response" do
        post :create, params: {reading: sample_reading}
        expect(response.response_code).to eql 401
      end

      it "Get Reading returns unauthorized response" do
        get :show, params: {id: reading.number}
        expect(response.response_code).to eql 401
      end

      it "Get Stats returns unauthorized response" do
        get :stats
        expect(response.response_code).to eql 401
      end
    end
  end
end
