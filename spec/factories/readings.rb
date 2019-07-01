FactoryBot.define do
  factory :reading do
    association :thermostat

    temperature { 24.5 }
    humidity { 24.5 }
    battery_charge { 52.5 }
  end
end
