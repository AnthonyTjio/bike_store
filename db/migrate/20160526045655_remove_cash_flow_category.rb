class RemoveCashFlowCategory < ActiveRecord::Migration
  def change
  	remove_column :cash_flows, :category
  end
end
