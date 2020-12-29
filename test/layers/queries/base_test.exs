defmodule MongoAgile.BaseTest do
  use ExUnit.Case

  test "use_base_definition" do

    defmodule Example do
      use MongoAgile.Queries.Helper.Base,
          name: "NAME_QUERY"
    end

    query = Example.from("test")
    assert query == %{base: %{collection: "test", pid_mongo: :mongo, query_name: "NAME_QUERY"}}
  end

end
