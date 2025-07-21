json.array!(@kucings) do |kucing|
  json.extract! kucing, :id
  json.url kucing_url(kucing, format: :json)
end
