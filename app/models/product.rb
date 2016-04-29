class Product < ActiveRecord::Base
  belongs_to :bike_model
  validates :bike_name, :bike_model_id, :price, :bike_size, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :confirmation, acceptance: true
  # validates :bike_model_id
end
