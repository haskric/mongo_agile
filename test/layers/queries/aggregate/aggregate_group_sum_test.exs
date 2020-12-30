defmodule MongoAgile.Queries.Aggregate.GroupSum.Test do
  @moduledoc false
  use ExUnit.Case

  use MongoAgile.Queries

  @collection "test_aggregate"

  def pipeline_count_total_views do
    stage_group = %{
      "$group" =>
        %{
        "_id" => nil,
        "sum_views" => %{
          "$sum" => "$views"
        }
      }
    }

    [stage_group]
  end

  test "definition_aggregate_count_total_views" do
    pipeline = pipeline_count_total_views()

    query = Aggregate.from(@collection)
    |> Aggregate.pipeline(pipeline)

    assert query == %{
      base: %{
        collection: "test_aggregate",
        pid_mongo: :mongo,
        query_name: "Aggregate"
      },
      pipeline: [
        %{"$group" => %{"_id" => nil, "sum_views" => %{"$sum" => "$views"}}}
      ]
    }
  end

  test "count_total_views" do
    pipeline = pipeline_count_total_views()

    result = Aggregate.from(@collection)
      |> Aggregate.pipeline(pipeline)
      |> exe_query()
      |> Enum.to_list()

    total_views = calcular_total_views()
    assert result == [%{"_id" => nil, "sum_views" => total_views}]
  end

  def calcular_total_views do
    {:ok, docs} = Find.from(@collection)
      |> exe_query()

    docs |> Enum.reduce(0, fn(doc, acc) ->
      acc + doc["views"]
    end)
  end

end
