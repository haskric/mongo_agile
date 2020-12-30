defmodule MongoAgile.Examples.Schema.Test do
  @moduledoc false
  use ExUnit.Case
  alias MongoAgile.Examples.Schema.SchemaController
  alias MongoAgile.Examples.Schema.SchemaModel

  test "insert document, get (with updating version) and get ( version ok) , and remove it." do

    doc_example = %{"name" => "Mary"}

    {flag, id_mongo} = SchemaController.run_query("create", [doc: doc_example])
    assert flag == :ok

    {:ok, {:versioning, "updating", doc}} = SchemaController.run_query("get", [id: id_mongo])

    assert SchemaModel.get_schema_version(doc) == 2
    assert SchemaModel.get_name(doc) == "Mary"

    # We wait a bit that the Task.start with the replace_one query finished.
    :timer.sleep(100)

    {:ok, {:versioning, "ok", doc}} = SchemaController.run_query("get", [id: id_mongo])

    assert SchemaModel.get_schema_version(doc) == 2
    assert SchemaModel.get_name(doc) == "Mary"

    result = SchemaController.run_query("remove", [id: id_mongo])
    assert result == {:ok, "it was deleted"}

  end

end
