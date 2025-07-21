class Customer < ActiveRecord::Base
	has_many :orders, dependent: :nullify
	validates_presence_of :customer_name, :customer_address
	validates_presence_of :customer_phone, message: "can't be blank and "
	validates_numericality_of :customer_phone, message: "should be number"
	
end
