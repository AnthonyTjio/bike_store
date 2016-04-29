class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_item, dependent: :destroy
end
