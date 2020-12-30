defmodule MongoAgile.BuilderQueries.DeleteOneBuilder do
  @moduledoc """
  Macro DeleteOne

  ## Base
    * `where` - Selector

  """
  defmodule Schema do
    @moduledoc false
    use MapSchema,
      atomize: true,
      schema: %{
          :where => :map
     }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.DeleteOneBuilder
    end
  end
  defmacro delete_one(description, keyword) do
    alias MongoAgile.BuilderQueries.DeleteOneBuilder
    alias MongoAgile.Queries.DeleteOne

    Generic.macro_query(description, keyword, DeleteOneBuilder, DeleteOne)
  end

end
