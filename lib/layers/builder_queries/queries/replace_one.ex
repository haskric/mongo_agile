defmodule MongoAgile.BuilderQueries.ReplaceOneBuilder do
  @moduledoc """
  Macro replace_one

  ## Base
    * `document` - Document to replace

  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:upsert` - if set to `true` creates a new document when no document
      matches the filter (default: `false`)
  """
  defmodule Schema do
  use MapSchema,
    atomize: true,
    schema: %{
        :where => :map,
        :document => :map,

        :upsert => :bool
    }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.ReplaceOneBuilder
    end
  end
  defmacro replace(description, keyword) do
    alias MongoAgile.Queries.ReplaceOne
    alias MongoAgile.BuilderQueries.ReplaceOneBuilder

    Generic.macro_query(description, keyword, ReplaceOneBuilder, ReplaceOne)
  end

end
