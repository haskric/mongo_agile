defmodule MongoAgile.Queries.InsertOne.Test do
  use ExUnit.Case

  alias MongoAgile.Queries.InsertOne
  alias MongoAgile.Queries.FindOne

  import MongoAgile.Queries.AgilQuery

  test "insert_one_definition" do

    query = InsertOne.from("test")
    |> InsertOne.doc(%{"example"=>"hello world"})

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "insert_one"},
      doc: %{"example"=>"hello world"}
    }
  end

  test "insert_one_execution" do

    original_doc = %{"example" => "hello world"}

    result = InsertOne.from("test")
      |> InsertOne.doc(original_doc)
      |> run_query()

    {flag, id_mongo} = result
    assert flag == :ok

    result = FindOne.from("test")
      |> FindOne.select_field("_id",id_mongo)
      |> run_query()

    {flag, doc} = result
    assert flag == :ok

    doc = doc
      |> Map.delete("_id")
    assert doc == original_doc

  end

end
