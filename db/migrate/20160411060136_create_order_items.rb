class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product, index: true, foreign_key: true
      t.belongs_to :order, index: true, foreign_key: true
      t.integer :qty

      t.timestamps null: false
    end
  end
end
