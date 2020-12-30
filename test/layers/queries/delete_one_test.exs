defmodule MongoAgile.Queries.DeleteOne.Test do
  @moduledoc false
  use ExUnit.Case

  alias MongoAgile.Queries.DeleteOne

  test "update_one_definition" do

    query = DeleteOne.from("test")
      |> DeleteOne.select_field("_id", "a")

    assert query == %{
      base: %{collection: "test", pid_mongo: :mongo, query_name: "DeleteOne"},
      selector: %{"_id" => "a"}
   }
  end

end
