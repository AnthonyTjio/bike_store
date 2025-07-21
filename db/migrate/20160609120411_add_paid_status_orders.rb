class AddPaidStatusOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paid, :boolean
  end
end
