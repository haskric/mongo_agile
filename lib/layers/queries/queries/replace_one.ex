defmodule MongoAgile.Queries.ReplaceOne do
  @moduledoc false
  #Athough the method of Mongo it´s replace_one(...) we can replace many documents.
  #BE CAREFUL

  use MapSchema,
  atomize: true,
  schema: %{
      :base => "<query_base>",
      :selector => :map,
      :doc => :map,
      :opts => :keyword
 },
  custom_types: %{
    "<query_base>" => MongoAgile.Queries.Helper.Base.Type
 }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "ReplaceOne"

  use MongoAgile.Queries.Helper.Selector
  use MongoAgile.Queries.Helper.Doc
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    selector = selector(query)
    doc = doc(query)
    opts = opts(query)

    Mongo.replace_one(pid_mongo, collection, selector, doc, opts)
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
      have_upserted_ids?(operation) ->
        {:ok , operation.upserted_ids}
      operation.modified_count > 0 and operation.matched_count > 0 ->
        {:ok , "updated"}
      operation.matched_count > 0 ->
        {:ok , "not modified"}
      true ->
        {:error, "not found item"}
    end
  end

  defp have_upserted_ids?(operation) do
    upserted_ids = operation.upserted_ids

    not is_nil(upserted_ids) and upserted_ids != []
  end

end
