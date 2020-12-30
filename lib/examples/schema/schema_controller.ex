defmodule MongoAgile.Examples.Schema.SchemaController do
  @moduledoc """
  SchemaController Example of controller have some example of using before and after methods.
  """

  use MongoAgile.Controller,
    collection: "test_schema_versioning",
    pid_mongo: :mongo

  alias MongoAgile.Examples.Schema.SchemaModel

  find_one "get",
    where: %{"_id" => id}
  def get_after(result_query) do
    case result_query do
      {:ok, doc} ->
        {:ok, SchemaModel.versioning(doc)}
      _otherwise ->
        result_query
    end
  end

  def create_before([doc: doc]) do
    doc = doc
      |> SchemaModel.timestamp_created()
      |> SchemaModel.timestamp_updated()

    [doc: doc]
  end

  insert_one "create", document: doc

  delete_one "remove", where: %{"_id" => id}

  def create_replace([doc: doc]) do
    doc = doc
      |> SchemaModel.timestamp_updated()

    [doc: doc]
  end

  replace "replace",
    document: doc,
    where: %{"_id" => id}

end
