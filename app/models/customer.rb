class Customer < ActiveRecord::Base
	has_many :orders, dependent: :destroy
	validates_presence_of :customer_name, :customer_address, :shipping_address, :customer_phone
	
end
