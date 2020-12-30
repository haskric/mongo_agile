defmodule MongoAgile.Queries.Find.Test do
  use ExUnit.Case

  alias MongoAgile.Queries.Find

  test "find_definition" do

    query = Find.from("test")
      |> Find.opts_key(:limit, 10)

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "Find"},
      opts: [{:limit, 10}]
    }
  end

end
