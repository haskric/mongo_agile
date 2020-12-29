defmodule MongoAgile.BuilderQueries.CRUDMany.Test do
  use ExUnit.Case

  defmodule Measure do
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_measures",
      pid_mongo: :mongo


    use MapSchema,
      schema: %{
          "category" => :string,
          "measurement" => :integer,
          "valid" => :bool
      }

    find "find_by_category",
      where: %{ "category" => category }

    insert "insert", documents: docs

    update "validation",
      set: %{
        "$max"=> %{ "measurement"=> 250 },
        "$set"=> %{ "valid" => true }
      },
      where: %{ "category" => category }

    delete "delete",
      where: %{ "category" => category }
  end


  test "CRUD MANY DOCUMENTS, using $max and $set" do

    insert_all()

    result = Measure.run_query("validation",[category: "CRUDMany"])
    assert result == {:ok, "they was updated"}

    result = Measure.run_query("find_by_category",[category: "CRUDMany"])

    {flag, list_docs} = result
    assert flag == :ok

    list_docs = list_docs |> Enum.map(fn(doc) ->
      doc
      |> Map.delete("_id")
    end)

    expected_docs = [
      %{ "category"=> "CRUDMany", "measurement" => 250 , "valid" => true },
      %{ "category"=> "CRUDMany", "measurement" => 250 , "valid" => true },
      %{ "category"=> "CRUDMany", "measurement" => 1000, "valid" => true }
    ]

    assert list_docs == expected_docs

    delete_all()
  end

  def delete_all() do
    result = Measure.run_query("delete",[category: "CRUDMany"])
    assert result == {:ok, "they was deleted"}
  end

  def insert_all() do
    original_docs = [
      %{ "category"=> "CRUDMany", "measurement" => 10},
      %{ "category"=> "CRUDMany", "measurement" => 100},
      %{ "category"=> "CRUDMany", "measurement" => 1000}
    ]

    result = Measure.run_query("insert",[docs: original_docs])

    {flag, _list_id_mongos} = result
    assert flag == :ok
  end



end
