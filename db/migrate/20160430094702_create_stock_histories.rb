class CreateStockHistories < ActiveRecord::Migration
  def change
    create_table :stock_histories do |t|
      t.belongs_to :stock, index: true, foreign_key: true
      t.integer :alteration
      t.text :description

      t.timestamps null: false
    end
  end
end
