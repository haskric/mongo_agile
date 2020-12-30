defmodule MongoAgile.BuilderQueries.CountDocumentsBuilder do
  @moduledoc """
  Macro Count

  ## Base
    * `where` - Selector

  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:limit` - Maximum number of documents to fetch with the cursor
    * `:skip` - Number of documents to skip before returning the first

  """
  defmodule Schema do
    @moduledoc false
    use MapSchema,
      atomize: true,
      schema: %{
          :where => :map,

          :limit => :integer,
          :skip => :integer
     }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.CountDocumentsBuilder
    end
  end
  defmacro count(description, keyword) do
    alias MongoAgile.BuilderQueries.CountDocumentsBuilder
    alias MongoAgile.Queries.CountDocuments

    Generic.macro_query(description, keyword, CountDocumentsBuilder, CountDocuments)
  end

end
