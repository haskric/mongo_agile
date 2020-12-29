defmodule MongoAgile.Controller do

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


      defdelegate run_query(query),
        to: MongoAgile.Queries.AgilQuery

    end
  end

end
