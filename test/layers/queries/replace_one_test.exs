defmodule MongoAgile.Queries.ReplaceOne.Test do
  @moduledoc false
  use ExUnit.Case
  alias MongoAgile.Queries.FindOne
  alias MongoAgile.Queries.ReplaceOne
  import MongoAgile.Queries.AgilQuery

  test "replace_one_definition" do

    query = ReplaceOne.from("test")
    |> ReplaceOne.select_field("_id", "a")
    |> ReplaceOne.doc(%{"example" => "hello world"})

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "ReplaceOne"},
      doc: %{"example"=>"hello world"},
      selector: %{"_id" => "a"}
    }
  end

  test "replace" do
    result = ReplaceOne.from("test")
      |> ReplaceOne.select_field("_id", "not_exit_id")
      |> ReplaceOne.doc(%{"example"=> "hello"})
      |> exe_query()

    assert result == {:error, "not found item"}
  end

  test "replace_one_execution" do
    id = "id_example_replace"
    now = System.os_time(:millisecond)

    original_doc = %{
      "_id" => id,
      "example" => "hello world",
      "last_update" => now
   }

    result = ReplaceOne.from("test")
      |> ReplaceOne.select_field("_id", id)
      |> ReplaceOne.doc(original_doc)
      |> ReplaceOne.opts_key(:upsert, true)
      |> exe_query()

    assert result == {:ok, "updated"}

    result = FindOne.from("test")
      |> FindOne.select_field("_id", id)
      |> exe_query()

    assert result == {:ok, original_doc}

  end

end
