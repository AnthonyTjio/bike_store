class CreateBikeModels < ActiveRecord::Migration
  def change
    create_table :bike_models do |t|
      t.string :model_name

      t.timestamps null: false
    end
  end
end
