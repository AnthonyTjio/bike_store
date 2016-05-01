class Stock < ActiveRecord::Base
  belongs_to :product
  has_many :stock_histories, dependent: :destroy
  validates :product_id, :qty, presence: true
  validates :qty, numericality: {greater_than_or_equal_to: 0}
end
