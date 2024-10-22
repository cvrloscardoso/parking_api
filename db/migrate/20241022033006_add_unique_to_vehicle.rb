class AddUniqueToVehicle < ActiveRecord::Migration[7.2]
  def change
    add_index :vehicles, :plate, unique: true
  end
end
