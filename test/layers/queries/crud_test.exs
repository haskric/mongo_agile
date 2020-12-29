defmodule MongoAgile.Queries.CRUD.Test do
  use ExUnit.Case

  use MongoAgile.Queries

  test "Insert, Update $inc, $set, find and delete" do

    original_doc = %{ "title"=> "hello world", "views" => 0}

    result = InsertOne.from("test")
      |> InsertOne.doc(original_doc)
      |> run_query()

    {flag, id_mongo} = result
    assert flag == :ok

    result = UpdateOne.from("test")
      |> UpdateOne.select_field("_id",id_mongo)
      |> UpdateOne.update(%{
        "$inc" => %{ "views" => 1 },
        "$set" => %{ "title" => "Hello W0rld, Mongo Agilers.."}
      })
      |> run_query()

    assert result == {:ok, "updated"}

    result = FindOne.from("test")
      |> FindOne.select_field("_id",id_mongo)
      |> run_query()

    {flag, doc} = result
    assert flag == :ok

    doc = doc
      |> Map.delete("_id")

    expected_doc = %{ "title"=> "Hello W0rld, Mongo Agilers..", "views" => 1}
    assert doc == expected_doc


    result = DeleteOne.from("test")
      |> DeleteOne.select_field("_id",id_mongo)
      |> run_query()

    assert result == {:ok, "it was deleted"}

  end

end
