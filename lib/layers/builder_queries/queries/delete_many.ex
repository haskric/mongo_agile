defmodule MongoAgile.BuilderQueries.DeleteManyBuilder do
  @moduledoc """
  Macro DeleteMany

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
      import MongoAgile.BuilderQueries.DeleteManyBuilder
    end
  end
  defmacro delete(description, keyword) do
    alias MongoAgile.BuilderQueries.DeleteManyBuilder
    alias MongoAgile.Queries.DeleteMany

    Generic.macro_query(description, keyword, DeleteManyBuilder, DeleteMany)
  end

end
