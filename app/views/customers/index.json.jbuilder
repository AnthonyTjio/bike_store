json.array!(@customers) do |customer|
  json.extract! customer, :id, :customer_name, :customer_address, :shipping_address, :customer_phone
  json.url customer_url(customer, format: :json)
end
