class Product < ActiveRecord::Base
  belongs_to :bike_model
  has_one :stock, dependent: :destroy
  validates :bike_name, :bike_model_id, :price, :bike_size, presence: true
  # validates :confirmation, acceptance: true
  # validates :bike_model_id
end
