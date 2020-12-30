defmodule MongoAgile.Controller do
  @moduledoc """
  Controller by default of MongoAgile

  Example of use:

  * Controller

  use MongoAgile.Controller,
      collection: "test_aggregate",
      pid_mongo: :mongo

  * Import AgilQuery + BulderQueries equivalent

  import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_aggregate",
      pid_mongo: :mongo


  You would can extends the functionality, if overwrite ``exe_query``

  The controller use exe_query method of AgilQuery, but other would
  can create a custom controller, with a other functionality overwriting the method.
  and easily the execution of queries will be change.

  """
  alias MongoAgile.Controller.ApiQueries

  defmacro __using__(opts) do
    collection = Keyword.get(opts, :collection)
    pid_mongo = Keyword.get(opts, :pid_mongo)
    flag_install_api = Keyword.get(opts, :install_api)

    [
      build_base(collection, pid_mongo),
      ApiQueries.install_api(flag_install_api)
    ]
    |> List.flatten()
  end

  defp build_base(collection, pid_mongo) do
    quote bind_quoted: [
      collection: collection,
      pid_mongo: pid_mongo]
    do

      use MongoAgile.BuilderQueries,
        collection: collection,
        pid_mongo: pid_mongo

      defdelegate exe_query(query),
        to: MongoAgile.Queries.AgilQuery

    end
  end

end
