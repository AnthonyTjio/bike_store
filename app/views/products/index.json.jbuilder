json.array!(@products) do |product|
  json.extract! product, :id, :bike_name, :bike_model_id, :price, :bike_size
  json.url product_url(product, format: :json)
end
