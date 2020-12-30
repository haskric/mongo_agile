defmodule MongoAgile.Queries.InsertMany.Test do
  use ExUnit.Case

  alias MongoAgile.Queries.InsertMany
  alias MongoAgile.Queries.Find
  alias MongoAgile.Queries.DeleteMany

  import MongoAgile.Queries.AgilQuery

  test "insert_many_definition" do

    query = InsertMany.from("test")
    |> InsertMany.docs([
      %{ "category"=> "A", "product" => 102 },
      %{ "category"=> "A", "product" => 123 }
    ])
    |> InsertMany.docs_add(%{ "category"=> "A", "product" => 12 })


    expected_query = %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "InsertMany"},
      docs: [
        %{ "category"=> "A", "product" => 102 },
        %{ "category"=> "A", "product" => 123 },
        %{ "category"=> "A", "product" => 12 }
      ]
    }
    assert query == expected_query
  end

  test "insert_many_execution" do

    original_docs = [
      %{ "category"=> "InsertManyTest", "product" => 102 },
      %{ "category"=> "InsertManyTest", "product" => 123 },
      %{ "category"=> "InsertManyTest", "product" => 12 }
    ]

    result = InsertMany.from("test")
      |> InsertMany.docs(original_docs)
      |> run_query()

    {flag, _list_id_mongos} = result
    assert flag == :ok

    result = Find.from("test")
      |> Find.select_field("category","InsertManyTest")
      |> run_query()

    {flag, list_docs} = result
    assert flag == :ok

    list_docs = list_docs |> Enum.map(fn(doc) ->
      doc
      |> Map.delete("_id")
    end)

    assert list_docs == original_docs

    result = DeleteMany.from("test")
      |> DeleteMany.select_field("category","InsertManyTest")
      |> run_query()

    assert result == {:ok, "they was deleted"}
  end

end
