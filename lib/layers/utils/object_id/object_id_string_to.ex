defimpl String.Chars, for: BSON.ObjectId do
  def to_string(bson_id) do
    BSON.ObjectId.encode!(bson_id)
  end
end
