class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :bike_name
      t.references :bike_model, index: true, foreign_key: true
      t.decimal :price
      t.string :bike_size

      t.timestamps null: false
    end
  end
end
