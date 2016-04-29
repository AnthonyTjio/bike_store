class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.text :customer_address
      t.text :shipping_address
      t.string :customer_phone

      t.timestamps null: false
    end
  end
end
