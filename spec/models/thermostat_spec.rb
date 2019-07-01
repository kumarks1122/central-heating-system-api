require 'rails_helper'

RSpec.describe Thermostat, type: :model do

  it "has a valid factory" do
    expect(build(:thermostat)).to be_valid
  end

  describe 'associations' do
    it { should have_many(:readings) }
  end
end
