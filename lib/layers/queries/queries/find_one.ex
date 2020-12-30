defmodule MongoAgile.Queries.FindOne do
  @moduledoc false
  use MapSchema,
    atomize: true,
    schema: %{
        :base => "<query_base>",
        :selector => :map,
        :opts => :keyword
    },
    custom_types: %{
      "<query_base>" => MongoAgile.Queries.Helper.Base.Type,
      :keyword => MongoAgile.MapSchema.KeywordType
    }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "find_one"
  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    opts = opts(query)

    Mongo.find_one(pid_mongo, collection, selector, opts)
  end

  def return(result_query) do
    case result_query do
      nil -> {:error, "not found"}
      doc -> {:ok, doc}
    end
  end

end
