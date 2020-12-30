defmodule MongoAgile.BuilderQueries.Aggregate.GroupSum.Test do
  @moduledoc false
  use ExUnit.Case

  defmodule DataSetExample do
    @moduledoc false
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_aggregate",
      pid_mongo: :mongo

    find "get_all", where: %{}

    aggregate "sum_views",
      pipeline: [
        %{
          "$group" =>
            %{
            "_id" => nil,
            "sum_views" => %{
              "$sum" => "$views"
            }
          }
        }
      ]
  end

  test "sum_views" do
    result = DataSetExample.run_query("sum_views")
      |> Enum.to_list()

    total_views = calcular_total_views()
    assert result == [%{"_id" => nil, "sum_views" => total_views}]
  end

  def calcular_total_views do
    {:ok, docs} = DataSetExample.run_query("get_all")

    docs |> Enum.reduce(0, fn(doc, acc) ->
      acc + doc["views"]
    end)
  end

end
