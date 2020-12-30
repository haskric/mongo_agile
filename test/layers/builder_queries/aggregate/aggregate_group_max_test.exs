defmodule MongoAgile.BuilderQueries.Aggregate.GroupMax.Test do
  @moduledoc false
  @doc """
  I would like a style... similar this... (stage -> map)

  aggregate "max_likes",
    match: %{},
    group: %{
      "_id" => nil,
      "max_likes" => %{
        "$avg" => "$likes"
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
