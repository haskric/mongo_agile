defmodule MongoAgile.BuilderQueries.Aggregate.GroupMin.Test do
  @moduledoc false
  use ExUnit.Case

  defmodule DataSetExample do
    @moduledoc false
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_aggregate",
      pid_mongo: :mongo

    find "get_all", where: %{}

    aggregate "min_likes",
      pipeline: [
        %{
          "$group" =>
            %{
            "_id" => nil,
            "min_likes" => %{
              "$min" => "$likes"
            }
          }
        }
      ]
  end

  test "min_likes" do
    result = DataSetExample.run_query("min_likes")
      |> Enum.to_list()

    min_likes = calcular_min_likes()
    assert result == [%{"_id" => nil, "min_likes" => min_likes}]
  end

  def calcular_min_likes do
    {:ok, docs} = DataSetExample.run_query("get_all")

    docs |> Enum.reduce(nil, fn(doc, acc) ->
      likes = doc["likes"]
      cond do
        acc == nil -> likes
        likes < acc -> likes
        true -> acc
      end
    end)
  end

end
