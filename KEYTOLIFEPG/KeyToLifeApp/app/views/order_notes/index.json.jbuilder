json.array!(@order_notes) do |order_note|
  json.extract! order_note, :id
  json.url order_note_url(order_note, format: :json)
end
