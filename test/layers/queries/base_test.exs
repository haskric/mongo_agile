defmodule MongoAgile.BaseTest do
  @moduledoc false
  use ExUnit.Case

  test "use_base_definition" do

    defmodule Example do
      @moduledoc false
      use MongoAgile.Queries.Helper.Base,
          name: "NAME_QUERY"
    end

    query = Example.from("test")
    assert query == %{base: %{collection: "test", pid_mongo: :mongo, query_name: "NAME_QUERY"}}
  end

end
