class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_item, dependent: :destroy
  enum status: [:not_paid, :not_sent, :sent]
  enum shipping_method: [:on_the_spot, :company_delivery, :external_courrier]

  accepts_nested_attributes_for :customer

end
