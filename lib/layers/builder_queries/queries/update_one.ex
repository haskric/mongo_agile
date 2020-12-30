defmodule MongoAgile.BuilderQueries.UpdateOneBuilder do
  @moduledoc """
  Macro UpdateOne

  ## Base
    * `set` - Update
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
      import MongoAgile.BuilderQueries.UpdateOneBuilder
    end
  end
  defmacro update_one(description, keyword) do
    alias MongoAgile.BuilderQueries.UpdateOneBuilder
    alias MongoAgile.Queries.UpdateOne

    Generic.macro_query(description, keyword, UpdateOneBuilder, UpdateOne)
  end

end
