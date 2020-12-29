defmodule MongoAgile.BuilderQueries.InsertOneBuilder do
  @moduledoc """
  Macro InsertOne

  ## Base
    * `document` - Document to insert

  """
  defmodule Schema do
  use MapSchema,
    atomize: true,
    schema: %{
        :document => :map
    }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.InsertOneBuilder
    end
  end
  defmacro insert_one(description, keyword) do
    alias MongoAgile.Queries.InsertOne
    alias MongoAgile.BuilderQueries.InsertOneBuilder

    Generic.macro_query(description, keyword, InsertOneBuilder, InsertOne)
  end

end
