defmodule MongoAgile.Queries.AgilQuery do
  @moduledoc """
  The main proxy function of execution of queries

  The ``exe_query(query)`` method can be overwrite using importing other
  module different than AgilQuery, and after call AgilQuery.

  * Controller

  use MongoAgile.Controller,
      collection: "test_aggregate",
      pid_mongo: :mongo

  * Import AgilQuery + BulderQueries equivalent

  import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_aggregate",
      pid_mongo: :mongo

  The controller use exe_query method of AgilQuery, but other would
  can create a custom controller, with a other functionality overwriting the method.
  and easily the execution of queries will be change.

  Sorry it´s this can generate confusion, but the idea with
  this architecture is be able of extend the functionality of the Library.

  """
  def exe_query(query) do
    module = get_module(query.base.query_name)
    apply(module, :exe, [query])
  end

  defp get_module(query_name) do
    Module.concat(MongoAgile.Queries, query_name)
  end

end
