FactoryBot.define do
  factory :thermostat do
    sequence(:location) { |n| "Rosenthaler Str. #{n}-64, 10119 Berlin, Germany" }
  end
end