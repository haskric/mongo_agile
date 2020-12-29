defmodule MongoAgile.BuilderQueries.FindOneBuilder do
  @moduledoc """
  Macro find_one

  ## Base
    * `where` - Selector

  ## Options
    * `:comment` - Associates a comment to a query
    * `:cursor_type` - Set to :tailable or :tailable_await to return a tailable
      cursor
    * `:max_time` - Specifies a time limit in milliseconds
    * `:modifiers` - Meta-operators modifying the output or behavior of a query,
      see http://docs.mongodb.org/manual/reference/operator/query-modifier/
    * `:cursor_timeout` - Set to false if cursor should not close after 10
      minutes (Default: true)
    * `:projection` - Limits the fields to return for all matching document
    * `:skip` - The number of documents to skip before returning (Default: 0)
  """
  defmodule Schema do
  use MapSchema,
    atomize: true,
    schema: %{
        :where => :map,

        :comment => :string,
        :cursor_type => :any,
        :max_time => :integer,
        :modifiers => :any,
        :cursor_timeout => :any,
        :projection => :any,
        :skip => :integer
    }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.FindOneBuilder
    end
  end
  defmacro find_one(description, keyword) do
    alias MongoAgile.Queries.FindOne
    alias MongoAgile.BuilderQueries.FindOneBuilder

    Generic.macro_query(description, keyword, FindOneBuilder, FindOne)
  end

end
