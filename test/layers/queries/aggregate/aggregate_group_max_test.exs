defmodule MongoAgile.Queries.Aggregate.GroupMax.Test do
  @moduledoc false
  use ExUnit.Case

  use MongoAgile.Queries

  @collection "test_aggregate"

  def pipeline_max_total_likes do
    stage_group = %{
      "$group" =>
        %{
        "_id" => nil,
        "max_likes" => %{
          "$max" => "$likes"
        }
      }
    }

    [stage_group]
  end

  test "definition_aggregate_max_total_likes" do
    pipeline = pipeline_max_total_likes()

    query = Aggregate.from(@collection)
    |> Aggregate.pipeline(pipeline)

    assert query == %{
      base: %{
        collection: "test_aggregate",
        pid_mongo: :mongo,
        query_name: "Aggregate"
      },
      pipeline: [
        %{"$group" => %{"_id" => nil, "max_likes" => %{"$max" => "$likes"}}}
      ]
    }
  end

  test "max_total_likes" do
    pipeline = pipeline_max_total_likes()

    result = Aggregate.from(@collection)
      |> Aggregate.pipeline(pipeline)
      |> exe_query()
      |> Enum.to_list()

    max_likes = calcular_max_likes()
    assert result == [%{"_id" => nil, "max_likes" => max_likes}]
  end

  def calcular_max_likes do
    {:ok, docs} = Find.from(@collection)
      |> exe_query()

    docs |> Enum.reduce(0, fn(doc, acc) ->
      likes = doc["likes"]
      if likes > acc do
        likes
      else
        acc
      end
    end)
  end

end
