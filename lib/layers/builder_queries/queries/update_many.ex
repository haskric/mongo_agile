defmodule MongoAgile.BuilderQueries.UpdateManyBuilder do
  @moduledoc """
  Macro UpdateMany

  ## Base
    * `where` - Selector


  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:upsert` - if set to `true` creates a new document when no document
      matches the filter (default: `false`)
  """
  defmodule Schema do
    @moduledoc false
    use MapSchema,
      atomize: true,
      schema: %{
          :set => :map,
          :where => :map,

          :upsert => :bool
     }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.UpdateManyBuilder
    end
  end
  defmacro update(description, keyword) do
    alias MongoAgile.BuilderQueries.UpdateManyBuilder
    alias MongoAgile.Queries.UpdateMany

    Generic.macro_query(description, keyword, UpdateManyBuilder, UpdateMany)
  end

end
