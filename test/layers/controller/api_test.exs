defmodule MongoAgile.Controller.ApiQueries.Test do
  use ExUnit.Case

  alias MongoAgile.Examples.Api.ApiController

  test "crud" do

    {:ok, id_mongo} = ApiController.post(%{"msg" => "hello"})

    {:ok, doc_in_mongo} = ApiController.get(id_mongo)
    assert doc_in_mongo["msg"] == "hello"

    result = ApiController.patch(id_mongo, %{"msg" => "hello world"})
    assert result == {:ok, "updated"}

    {:ok, doc_in_mongo} = ApiController.get(id_mongo)
    assert doc_in_mongo["msg"] == "hello world"

    result = ApiController.put(id_mongo, %{"message" => "hi"})
    assert result == {:ok, "updated"}

    {:ok, doc_in_mongo} = ApiController.get(id_mongo)
    assert doc_in_mongo["msg"] == nil
    assert doc_in_mongo["message"] == "hi"

    result = ApiController.delete(id_mongo)
    assert result == {:ok, "it was deleted"}
  end

end
