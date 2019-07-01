class Reading < ApplicationRecord
  belongs_to :thermostat

  before_validation(:on => :create) do
    self.number = next_seq unless attribute_present?("number")
  end

  def self.next_seq
    result = Reading.connection.execute("SELECT nextval('household_sequence')")

    result[0]['nextval']
  end 
end
