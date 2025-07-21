class AddShippingDetailsOrderSchema < ActiveRecord::Migration
  def change
    add_column :orders, :receipt_number, :string
    add_column :orders, :shipping_date, :date
  end
end
