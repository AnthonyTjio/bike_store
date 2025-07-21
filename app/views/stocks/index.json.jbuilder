json.array!(@stocks) do |stock|
  json.extract! stock, :id, :qty
  
  json.product do |json|
  	json.extract! stock.product, :id, :bike_name, :bike_model_id, :price, :bike_size

  	json.bike_model stock.product.bike_model, :id, :bike_model_name
  end
  
  json.url stock_url(stock, format: :json)
end
