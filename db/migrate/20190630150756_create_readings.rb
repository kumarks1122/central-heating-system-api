class CreateReadings < ActiveRecord::Migration[5.2]
  def self.up
    create_table :readings do |t|
      t.references :thermostat, foreign_key: true
      t.integer :number
      t.float :temperature, null: false
      t.float :humidity, null: false
      t.float :battery_charge, null: false

      t.timestamps
    end

    execute "CREATE SEQUENCE household_sequence START 1"
  end

  def self.down
    drop_table :readings

    execute "DROP SEQUENCE household_sequence"
  end
end
