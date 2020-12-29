defmodule MongoAgile.Examples.Api.ApiController do

  use MongoAgile.Controller,
    collection: "test_api",
    pid_mongo: :mongo,
    install_api: true

end
