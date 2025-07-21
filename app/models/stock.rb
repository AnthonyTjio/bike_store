class Stock < ActiveRecord::Base
  belongs_to :product
  has_many :stock_histories, dependent: :destroy
  validates :product_id, :qty, presence: true
  validates :qty, numericality: {greater_than_or_equal_to: 0, message: "cannot be less than 0"}
  validates_uniqueness_of :product_id
end
