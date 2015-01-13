json.array!(@greenideas) do |greenidea|
  json.extract! greenidea, :id
  json.url greenidea_url(greenidea, format: :json)
end
