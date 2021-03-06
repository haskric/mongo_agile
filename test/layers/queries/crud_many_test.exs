defmodule MongoAgile.Queries.CRUDMany.Test do
  @moduledoc false
  use ExUnit.Case

  use MongoAgile.Queries

  @collection "test_crudmany"

  test "CRUD MANY DOCUMENTS, using $max and $set" do

    insert_all()

    result = UpdateMany.from(@collection)
      |> UpdateMany.select_field("category", "CRUDMany")
      |> UpdateMany.update(%{
        "$max"=> %{"measurement"=> 250},
        "$set"=> %{"valid" => true}
     })
      |> exe_query()

    assert result == {:ok, "they was updated"}

    result = Find.from(@collection)
      |> Find.select_field("category", "CRUDMany")
      |> exe_query()

    {flag, list_docs} = result
    assert flag == :ok

    list_docs = list_docs |> Enum.map(fn(doc) ->
      doc
      |> Map.delete("_id")
    end)

    expected_docs = [
      %{"category"=> "CRUDMany", "measurement" => 250 , "valid" => true},
      %{"category"=> "CRUDMany", "measurement" => 250 , "valid" => true},
      %{"category"=> "CRUDMany", "measurement" => 1000, "valid" => true}
    ]

    assert list_docs == expected_docs

    result = CountDocuments.from(@collection)
      |> CountDocuments.selector(%{})
      |> exe_query()

    assert result == {:ok, 3}

    delete_all()
  end

  def delete_all do

    result = DeleteMany.from(@collection)
      |> DeleteMany.select_field("category", "CRUDMany")
      |> exe_query()

    assert result == {:ok, "they was deleted"}
  end

  def insert_all do
    original_docs = [
      %{"category"=> "CRUDMany", "measurement" => 10},
      %{"category"=> "CRUDMany", "measurement" => 100},
      %{"category"=> "CRUDMany", "measurement" => 1000}
    ]

    result = InsertMany.from(@collection)
      |> InsertMany.docs(original_docs)
      |> exe_query()

    {flag, _list_id_mongos} = result
    assert flag == :ok
  end

end
