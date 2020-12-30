defmodule MongoAgile.Queries.Aggregate.Groupavg.Test do
  @moduledoc false
  @doc """
  I would like a style... similar this... (stage -> map)

  aggregate "avg_views",
    match: %{},
    group: %{
      "_id" => nil,
      "avg_views" => %{
        "$avg" => "$views"
      }
    }

  But maybe it´s more flexible this...

  aggregate "", pipeline: [
    stage1,
    stage2,
    ...
  ]
  """
  use ExUnit.Case

  use MongoAgile.Queries

  @collection "test_aggregate"

  def pipeline_avg_views do
    stage_group = %{
      "$group" =>
        %{
        "_id" => nil,
        "avg_views" => %{
          "$avg" => "$views"
        }
      }
    }

    [stage_group]
  end

  test "definition_aggregate_avg_views" do
    pipeline = pipeline_avg_views()

    query = Aggregate.from(@collection)
    |> Aggregate.pipeline(pipeline)

    assert query == %{
      base: %{
        collection: "test_aggregate",
        pid_mongo: :mongo,
        query_name: "Aggregate"
      },
      pipeline: [
        %{"$group" => %{"_id" => nil, "avg_views" => %{"$avg" => "$views"}}}
      ]
    }
  end

  test "avg_views" do
    pipeline = pipeline_avg_views()

    result = Aggregate.from(@collection)
      |> Aggregate.pipeline(pipeline)
      |> exe_query()
      |> Enum.to_list()

    avg_views = calcular_avg_views()
    assert result == [%{"_id" => nil, "avg_views" => avg_views}]
  end

  def calcular_avg_views do
    {:ok, docs} = Find.from(@collection)
      |> exe_query()

    {total, count} = docs
    |> Enum.reduce({0, 0}, fn(doc, {acc_sum, acc_count}) ->
      acc_sum = acc_sum + doc["views"]
      acc_count = acc_count + 1

      {acc_sum, acc_count}
    end)

    avg = total / count
    avg
  end

end
