defmodule MongoAgile.Queries.Find do
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
    name: "find"
  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Opts


  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    opts = opts(query)

    Mongo.find(pid_mongo, collection, selector, opts)
  end

  def return(nil) do
    {:error, "they wasnt found"}
  end
  def return(result_query) do
    case result_query do
      nil ->
        {:error, "they wasnt found"}
      cursor ->
        result = cursor |> Enum.to_list()
        {:ok, result}
    end
  end

end
