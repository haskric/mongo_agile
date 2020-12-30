defmodule MongoAgile.Queries.InsertMany do
  @moduledoc false
  use MapSchema,
  atomize: true,
  schema: %{
      :base => "<query_base>",
      :docs => :list,
      :opts => :keyword
  },
  custom_types: %{
    "<query_base>" => MongoAgile.Queries.Helper.Base.Type,
    :keyword => MongoAgile.MapSchema.KeywordType
  }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "insert_many"

  use MongoAgile.Queries.Helper.DocList
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    docs = docs(query)
    opts = opts(query)

    Mongo.insert_many(pid_mongo, collection, docs, opts)
  end

  def return(result_query) do
    case result_query do
      {:ok, operation} ->
        {:ok, operation.inserted_ids}
      {:error, %Mongo.WriteError{write_errors: [main_error | _rest_errors]}} ->
        {:error , main_error["errmsg"]}
      _ ->
        {:error , "internal_error"}
    end
  end

end
