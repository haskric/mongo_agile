defimpl Jason.Encoder, for: BSON.ObjectId do
  def encode(bson_id , _args) do
    id_string_format = BSON.ObjectId.encode!(bson_id)
    id_string_with_json_format = "\"#{id_string_format}\""

    id_string_with_json_format
  end
end
