defmodule MongoAgile.Examples.Api.ApiController do
  @moduledoc """
  ApiController example of use install_api
  """
  use MongoAgile.Controller,
    collection: "test_api",
    pid_mongo: :mongo,
    install_api: true

  # When install_api: true
  # You will can use the following methods
  #
  # get(id)
  # post(doc)
  # put(id, doc)
  # delete(id)
  # patch(id, changeset)

  #... here more queries that you need ...
end
