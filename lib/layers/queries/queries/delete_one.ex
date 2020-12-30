defmodule MongoAgile.Queries.DeleteOne do
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
    name: "DeleteOne"

  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    opts = opts(query)

    Mongo.delete_one(pid_mongo, collection, selector, opts)
  end

  def return(result_query) do
    case result_query do
      {:ok, delete_result} ->
        if delete_result.deleted_count > 0 do
          {:ok, "it was deleted"}
        else
          {:error, "item don´t found"}
        end
      e ->
        {:error, e}
    end
  end

end
