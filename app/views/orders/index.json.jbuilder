json.array!(@orders) do |order|
  json.extract! order, :id, :customer_id, :order_date, :order_time, :status
  json.url order_url(order, format: :json)
end
