class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates_presence_of :order_id, :product_id, :qty, :price
  validates :qty, numericality: {greater_than_or_equal_to: 1, message: "cannot be less than 1"}
end
