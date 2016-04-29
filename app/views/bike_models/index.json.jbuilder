json.array!(@bike_models) do |bike_model|
  json.extract! bike_model, :id, :model_name
  json.url bike_model_url(bike_model, format: :json)
end
