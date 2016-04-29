class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer, index: true, foreign_key: true
      t.date :order_date
      t.time :order_time
      t.string :status

      t.timestamps null: false
    end
  end
end
