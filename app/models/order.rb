 class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_item, dependent: :destroy
  
  before_create :set_initial_status
  before_destroy :check_credentials
  
  validates :customer_id, presence: true
  
  enum status: [:pre_order, :active_order, :finished, :cancelled]
  enum shipping_method: [:on_the_spot, :delivery]

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
  
  def self.cancel_order
    if(User.find_by(id: session[user_id]).user_type == "Admin")
      self.cancelled!
    else
      errors.add(:message, "Only admin can cancel orders!")
    end
  end
  
  def set_initial_status
    self.is_paid = false
    self.is_delivered = false
    self.pre_order!
  end 
  
end
