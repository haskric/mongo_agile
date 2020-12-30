defmodule MongoAgile.Queries.UpdateOne do
  @moduledoc false
  use MapSchema,
  atomize: true,
  schema: %{
      :base => "<query_base>",
      :selector => :map,
      :update => "<query_update>",
      :opts => :keyword
  },
  custom_types: %{
    "<query_base>" => MongoAgile.Queries.Helper.Base.Type,
    "<query_update>" => MongoAgile.Queries.Helper.Update.Type
  }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "UpdateOne"

  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Opts
  use MongoAgile.Queries.Helper.Update

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    update = update(query)
    opts = opts(query)

    Mongo.update_one(pid_mongo, collection, selector, update, opts)
  end

  def return(result_query) do
    case result_query do
      {:ok, operation} ->
        response_ok_update(operation)
      e ->
        {:error , e}
    end
  end

  defp response_ok_update(operation) do
    cond do
      operation.modified_count > 0 and operation.matched_count > 0 ->
        {:ok , "updated"}
      operation.matched_count > 0 ->
        {:ok , "not modified"}
      true ->
        {:error, "not found item"}
    end
  end

end
