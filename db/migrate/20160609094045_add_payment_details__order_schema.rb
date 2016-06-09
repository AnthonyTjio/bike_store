class AddPaymentDetailsOrderSchema < ActiveRecord::Migration
  def change
    remove_column :orders, :order_time
    add_column :orders, :payment_date, :date
    add_column :orders, :payment_method, :integer
    add_column :orders, :atm_account, :string
  end
end
