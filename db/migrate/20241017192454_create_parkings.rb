class CreateParkings < ActiveRecord::Migration[7.2]
  def change
    create_table :parkings do |t|
      t.boolean :paid, null: false
      t.date :entry_time, null: false
      t.date :exit_time

      t.references :vehicle

      t.timestamps
    end
  end
end
