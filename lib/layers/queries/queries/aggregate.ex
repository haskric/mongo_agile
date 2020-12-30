defmodule MongoAgile.Queries.Aggregate do
  @moduledoc false
  use MapSchema,
    atomize: true,
    schema: %{
        :base => "<query_base>",
        :pipeline => :list,
        :opts => :keyword
   },
    custom_types: %{
      "<query_base>" => MongoAgile.Queries.Helper.Base.Type
   }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "Aggregate"
  use MongoAgile.Queries.Helper.Opts
  use MongoAgile.Queries.Helper.Pipeline

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    pipeline = pipeline(query)
    opts = opts(query)

    Mongo.aggregate(pid_mongo, collection, pipeline, opts)
  end

  def return(result), do: result

end
