defmodule MongoAgile.BuilderQueries.InsertManyBuilder do
  @moduledoc """
  Macro InsertMany

  ## Base
    * `documents` - List of Documents to insert


  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:continue_on_error` - even if insert fails for one of the documents
      continue inserting the remaining ones (default: `false`)
    * `:ordered` - A boolean specifying whether the mongod instance should
      perform an ordered or unordered insert. (default: `true`)

  """
  defmodule Schema do
    @moduledoc false
    use MapSchema,
      atomize: true,
      schema: %{
          :documents => :list,
          :continue_on_error => :bool,
          :ordered => :bool
     }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.InsertManyBuilder
    end
  end
  defmacro insert(description, keyword) do
    alias MongoAgile.BuilderQueries.InsertManyBuilder
    alias MongoAgile.Queries.InsertMany

    Generic.macro_query(description, keyword, InsertManyBuilder, InsertMany)
  end

end
