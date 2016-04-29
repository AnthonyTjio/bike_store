# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customers = [
	["Ken Toshi", "Jl Cakalang 14", "12344321", "Jl Cakalang 14"],
	["Shuu Nakamiya", "Jl Eboni 26", "43211234", "Jl Eboni 26"],
	["Anthony", "Binus Square", "0808080800", "Binus Square"]
]

customers.each do |data|
	Customer.create(customer_name:data[0], customer_address:data[1], customer_phone:data[2], shipping_address:data[3]);
end

bike_models = [
	["JavaX"],
	["Volvo"],
	["Dino"]
]

bike_models.each do |data|
	BikeModel.create(bike_model_name:data[0]);
end
