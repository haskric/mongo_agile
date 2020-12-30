defmodule MongoAgile.Queries.InsertOne do
  @moduledoc false
  use MapSchema,
  atomize: true,
  schema: %{
      :base => "<query_base>",
      :doc => :map,
      :opts => :keyword
  },
  custom_types: %{
    "<query_base>" => MongoAgile.Queries.Helper.Base.Type,
    :keyword => MongoAgile.MapSchema.KeywordType
  }

  use MongoAgile.Queries.Helper.Common
  use MongoAgile.Queries.Helper.Base,
    name: "insert_one"

  use MongoAgile.Queries.Helper.Doc
  use MongoAgile.Queries.Helper.Opts

  def run(query) do
    pid_mongo = pid_mongo(query)
    collection = collection(query)
    doc = doc(query)
    opts = opts(query)

    Mongo.insert_one(pid_mongo, collection, doc, opts)
  end

  def return(result_query) do
    case result_query do
      {:ok, operation} ->
        {:ok, operation.inserted_id}
      {:error, %Mongo.WriteError{write_errors: [main_error | _rest_errors]}} ->
        {:error , main_error["errmsg"]}
      _ ->
        {:error , "internal_error"}
    end
  end

end
