class RemodelOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :paid
    remove_column :orders, :payment_method
    remove_column :orders, :atm_account
    remove_column :orders, :shipping_cost
    add_column :orders, :is_paid, :boolean
    add_column :orders, :is_delivered, :boolean
  end
end
