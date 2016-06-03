class Customer < ActiveRecord::Base
	has_many :orders, dependent: :nullify
	validates_presence_of :customer_name, :customer_address, :customer_phone
	
end
