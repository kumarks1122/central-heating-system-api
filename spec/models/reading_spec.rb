require 'rails_helper'

RSpec.describe Reading, type: :model do

  it "has a valid factory" do
    expect(build(:reading)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:thermostat) }
  end
end
