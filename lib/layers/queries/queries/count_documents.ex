defmodule MongoAgile.Queries.CountDocuments do
  @moduledoc false
  use MapSchema,
    atomize: true,
    schema: %{
        :base => "<query_base>",
        :selector => :map,
        :opts => :keyword
   },
    custom_types: %{
      "<query_base>" => MongoAgile.Queries.Helper.Base.Type
   }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "CountDocuments"
  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    opts = opts(query)

    Mongo.count_documents(pid_mongo, collection, selector, opts)
  end

  def return({:ok, count}), do: {:ok, count}
  def return(_), do: {:error, "couldnt count the documents"}

end
