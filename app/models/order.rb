class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_item, dependent: :destroy
  
  validates :customer_id, presence: true
  
  enum status: [:pre_order, :active_order, :on_delivery, :done, :void]
  enum shipping_method: [:on_the_spot, :company_delivery, :jne]

  accepts_nested_attributes_for :customer

  def self.confirm_order
    if(self.order.status.pre_order?)
      if(self.order_item.present?)
        self.status.active_order!
        self.order_date = Date.today
        self.paid = false
      else
        errors.add(:message, "Cart cannot be empty")
      end
    elsif (self.status.void?)
      errors.add(:message, "The order is already void")
    elsif (self.status.done?)
      errors.add(:message, "The order is already finished")
    else
      errors.add(:message, "Confirmed orders cannot be modified")
    end
  end
  
  def self.ready_for_ship
    if(self.status.active_order?)
      if(self.paid?)
        self.status.on_delivery!
      else
        errors.add(:message, "Customer should pay before we can deliver the orders")
      end
    elsif (self.status.pre_order?)
      errors.add(:message, "The orders should be confirmed first")
    elsif (self.status.void?)
      errors.add(:message, "The order is already void")
    elsif (self.status.done?)
      errors.add(:message, "The orders is already finished")
    end
  end
  
  def self.finalize_order
    if(self.status.on_delivery?)
      self.status.done!
    else
      errors.add(:message, "The order has not been delivered")
    end
  end
    

end
