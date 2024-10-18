class CreateParkings < ActiveRecord::Migration[7.2]
  def change
    create_table :parkings do |t|
      t.boolean :paid, null: false, default: false
      t.datetime :entry_time, null: false
      t.datetime :exit_time

      t.references :vehicle

      t.timestamps
    end
  end
end
