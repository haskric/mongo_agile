defmodule MongoAgile.Queries.AgilQuery do
  @moduledoc """
  The main proxy function of execution of queries
  """
  def run_query(query) do
    module = get_module(query.base.query_name)
    apply(module, :exe, [query])
  end

  defp get_module(query_name) do
    Module.concat(MongoAgile.Queries, query_name)
  end

end
