defmodule MongoAgile.Queries.AgilQuery do
  @moduledoc false
  def run_query(query) do
    module = get_module(query.base.query_name)
    apply(module, :exe, [query])
  end

  defp get_module(query_name) do
    case query_name do
      "find_one" -> MongoAgile.Queries.FindOne
      "find" -> MongoAgile.Queries.Find
      "insert_one" -> MongoAgile.Queries.InsertOne
      "insert_many" -> MongoAgile.Queries.InsertMany
      "update_one" -> MongoAgile.Queries.UpdateOne
      "update_many" -> MongoAgile.Queries.UpdateMany
      "delete_one" -> MongoAgile.Queries.DeleteOne
      "delete_many" ->  MongoAgile.Queries.DeleteMany
      "replace" -> MongoAgile.Queries.ReplaceOne
    end
  end

end
