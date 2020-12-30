defmodule MongoAgile.Queries.FindOne.Test do
  use ExUnit.Case

  alias MongoAgile.Queries.FindOne

  test "find_one_definition" do

    query = FindOne.from("back_accounts")
    |> FindOne.select_field("_id","a")

    assert query == %{
      base: %{collection: "back_accounts", pid_mongo: :mongo, query_name: "FindOne"},
      selector: %{"_id" => "a"}
    }
  end

end
