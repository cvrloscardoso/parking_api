class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :plate, null: false

      t.timestamps
    end
  end
end
