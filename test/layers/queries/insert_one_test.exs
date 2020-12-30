defmodule MongoAgile.Queries.InsertOne.Test do
  @moduledoc false
  use ExUnit.Case

  alias MongoAgile.Queries.FindOne
  alias MongoAgile.Queries.InsertOne

  import MongoAgile.Queries.AgilQuery

  test "insert_one_definition" do

    query = InsertOne.from("test")
    |> InsertOne.doc(%{"example"=>"hello world"})

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "InsertOne"},
      doc: %{"example"=>"hello world"}
    }
  end

  test "insert_one_execution" do

    original_doc = %{"example" => "hello world"}

    result = InsertOne.from("test")
      |> InsertOne.doc(original_doc)
      |> exe_query()

    {flag, id_mongo} = result
    assert flag == :ok

    result = FindOne.from("test")
      |> FindOne.select_field("_id", id_mongo)
      |> exe_query()

    {flag, doc} = result
    assert flag == :ok

    doc = doc
      |> Map.delete("_id")
    assert doc == original_doc

  end

end
