class CreateKucings < ActiveRecord::Migration
  def change
    create_table :kucings do |t|

      t.timestamps null: false
    end
  end
end
