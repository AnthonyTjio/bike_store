class BikeModel < ActiveRecord::Base
	has_many :products
	validates_uniqueness_of :bike_model_name, :case_sensitive => false
	validates_presence_of :bike_model_name
end
