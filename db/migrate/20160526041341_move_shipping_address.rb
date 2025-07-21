class MoveShippingAddress < ActiveRecord::Migration
  def change
  	remove_column :customers, :shipping_address
  	add_column :orders, :shipping_address, :text
  end
end
