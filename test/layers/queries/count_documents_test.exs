defmodule MongoAgile.Queries.CountDocuments.Test do
  @moduledoc false
  use ExUnit.Case

  alias MongoAgile.Queries.CountDocuments

  test "count_documents_definition" do

    query = CountDocuments.from("test")
      |> CountDocuments.selector(%{})

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "CountDocuments"},
      selector: %{}
   }
  end

end
