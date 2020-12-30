defmodule MongoAgile.BuilderQueries.Aggregate.GroupMax.Test do
  @moduledoc false
  use ExUnit.Case

  defmodule DataSetExample do
    @moduledoc false
    use MongoAgile.Controller,
      collection: "test_aggregate",
      pid_mongo: :mongo

    find "get_all", where: %{}

    aggregate "max_likes",
      pipeline: [
        %{
          "$group" =>
            %{
            "_id" => nil,
            "max_likes" => %{
              "$max" => "$likes"
            }
          }
        }
      ]
  end

  test "max_likes" do
    result = DataSetExample.run_query("max_likes")
      |> Enum.to_list()

    max_likes = calcular_max_likes()
    assert result == [%{"_id" => nil, "max_likes" => max_likes}]
  end

  def calcular_max_likes do
    {:ok, docs} = DataSetExample.run_query("get_all")

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
