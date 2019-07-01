class ReadingSerializer < ActiveModel::Serializer
  attributes :temperature, :humidity, :battery_charge
end
