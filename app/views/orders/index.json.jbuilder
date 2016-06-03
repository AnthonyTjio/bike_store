json.array!(@orders) do |order|
  json.extract! order, :id, :shipping_address, :shipping_method, :order_date, :order_time, :status
  json.customer order.customer, :id, :customer_name, :customer_address, :customer_address, :customer_phone
  #json.url order_url(order, format: :json)
end
