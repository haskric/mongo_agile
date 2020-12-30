defmodule MongoAgile.Queries.Aggregate.GroupMin.Test do
  @moduledoc false
  use ExUnit.Case

  use MongoAgile.Queries

  @collection "test_aggregate"

  def pipeline_min_likes do
    stage_group = %{
      "$group" =>
        %{
        "_id" => nil,
        "min_likes" => %{
          "$min" => "$likes"
        }
      }
    }

    [stage_group]
  end

  test "definition_aggregate_min_likes" do
    pipeline = pipeline_min_likes()

    query = Aggregate.from(@collection)
    |> Aggregate.pipeline(pipeline)

    assert query == %{
      base: %{
        collection: "test_aggregate",
        pid_mongo: :mongo,
        query_name: "Aggregate"
      },
      pipeline: [
        %{"$group" => %{"_id" => nil, "min_likes" => %{"$min" => "$likes"}}}
      ]
    }
  end

  test "min_likes" do
    pipeline = pipeline_min_likes()

    result = Aggregate.from(@collection)
      |> Aggregate.pipeline(pipeline)
      |> exe_query()
      |> Enum.to_list()

    min_likes = calcular_min_likes()
    assert result == [%{"_id" => nil, "min_likes" => min_likes}]
  end

  def calcular_min_likes do
    {:ok, docs} = Find.from(@collection)
      |> exe_query()

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
