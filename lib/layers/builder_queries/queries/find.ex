defmodule MongoAgile.BuilderQueries.FindBuilder do
  @moduledoc """
  Macro find

  ## Base
    * `where` - Selector

  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:comment` - Associates a comment to a query
    * `:cursor_type` - Set to :tailable or :tailable_await to return a tailable
      cursor
    * `:max_time` - Specifies a time limit in milliseconds
    * `:modifiers` - Meta-operators modifying the output or behavior of a query,
      see http://docs.mongodb.org/manual/reference/operator/query-modifier/
    * `:cursor_timeout` - Set to false if cursor should not close after 10
      minutes (Default: true)
    * `:sort` - Sorts the results of a query in ascending or descending order
    * `:projection` - Limits the fields to return for all matching document
    * `:skip` - The number of documents to skip before returning (Default: 0)

  """
  defmodule Schema do
  use MapSchema,
    atomize: true,
    schema: %{
        :where => :map,

        :limit => :integer,
        :comment => :string,
        :cursor_type => :any,
        :max_time => :integer,
        :modifiers => :any,
        :cursor_timeout => :any,
        :sort => :any,
        :projection => :any,
        :skip => :integer
    }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.FindBuilder
    end
  end
  defmacro find(description, keyword) do
    alias MongoAgile.Queries.Find
    alias MongoAgile.BuilderQueries.FindBuilder

    Generic.macro_query(description, keyword, FindBuilder, Find)
  end

end
