defmodule MongoAgile.Utils.ObjectId.Test do
  @moduledoc false
  use ExUnit.Case
  doctest MongoAgile.MapSchema.IdObjectType

  test "objectid_to_string" do

    mongo_id_str = "5feaeb1e10fb18469bbd7336"
    mongo_id =  BSON.ObjectId.decode!(mongo_id_str)

    assert to_string(mongo_id) == mongo_id_str
  end

  test "objectid_to_json_with_jason" do

    mongo_id_str = "5feaeb1e10fb18469bbd7336"
    mongo_id =  BSON.ObjectId.decode!(mongo_id_str)

    doc_in_json = Jason.encode!(%{"_id" => mongo_id , "msg" => "hello world"})

    assert doc_in_json == "{\"_id\":\"#{mongo_id_str}\",\"msg\":\"hello world\"}"
  end

end
