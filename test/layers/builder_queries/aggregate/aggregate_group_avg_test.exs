defmodule MongoAgile.BuilderQueries.Aggregate.Groupavg.Test do
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

  defmodule DataSetExample do
    @moduledoc false
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_aggregate",
      pid_mongo: :mongo

    find "get_all", where: %{}

    aggregate "avg_views",
      pipeline: [
        %{
          "$group" =>
            %{
            "_id" => nil,
            "avg_views" => %{
              "$avg" => "$views"
            }
          }
        }
      ]
  end

  test "avg_views" do
    result = DataSetExample.run_query("avg_views")
      |> Enum.to_list()

    avg_views = calcular_avg_views()
    assert result == [%{"_id" => nil, "avg_views" => avg_views}]
  end

  def calcular_avg_views do
    {:ok, docs} = DataSetExample.run_query("get_all")

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
