class OrderItemAddPrice < ActiveRecord::Migration
  def change
  	add_column :order_items, :price, :integer
  end
end
