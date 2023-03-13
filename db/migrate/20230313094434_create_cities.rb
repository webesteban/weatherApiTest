class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.string :temperature
      t.string :lat
      t.string :lon
      t.string :icon

      t.timestamps
    end
  end
end
