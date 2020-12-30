defmodule MongoAgile.Queries.UpdateOne.Test do
  use ExUnit.Case

  alias MongoAgile.Queries.UpdateOne

  test "update_one_definition" do

    query = UpdateOne.from("test")
      |> UpdateOne.select_field("_id","a")
      |> UpdateOne.update(%{"$set" => %{ "field1" => "hello" }})

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "UpdateOne"},
      selector: %{"_id" => "a"},
      update: %{"$set" => %{"field1" => "hello"}}
    }
  end

  test "error_update_one_definition" do

    try do
      UpdateOne.from("test")
      |> UpdateOne.select_field("_id","a")
      |> UpdateOne.update(%{"$OPERATOR_NOT_DEFINED" => %{ "field1" => "hello" }})

    catch
      e ->
        assert e == MapSchema.Exceptions.type_error("update", "<query_update>")
    end

  end

end
