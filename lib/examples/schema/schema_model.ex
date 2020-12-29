defmodule MongoAgile.Examples.Schema.SchemaModel do

  use MapSchema,
    schema: %{
        "_id" => :any,
        "schema_version" => :integer,
        "name" => :string,
        "timestamp" => %{
          "created" => :integer,
          "last_updated" => :integer
        }
    }

  @schema_version 2

  def schema_version, do: @schema_version

  alias MongoAgile.Examples.Schema.SchemaController
  def versioning(doc) do
   if doc["schema_version"] == @schema_version do
     {:versioning, "ok", doc}
   else
     # Update version
     doc = put_schema_version(doc, @schema_version)

     Task.start(fn() ->
        SchemaController.run_query("replace", [id: doc["_id"], doc: doc])
     end)

     {:versioning, "updating", doc}
   end
  end

  def timestamp_created(doc) do
    now = System.os_time(:millisecond)

    doc
    |> put_timestamp_created(now)
  end
  def timestamp_updated(doc) do
    now = System.os_time(:millisecond)

    doc
    |> put_timestamp_last_updated(now)
  end

end
