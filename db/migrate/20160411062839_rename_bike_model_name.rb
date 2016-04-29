class RenameBikeModelName < ActiveRecord::Migration
  def change
  	rename_column :bike_models, :model_name, :bike_model_name
  end
end
