defmodule MongoAgile.BuilderQueries.AggregateBuilder do
  @moduledoc """
  Macro Pipeline

  ## Base
    * `pipeline` - Pipeline aggregate

  ## Options
    Source: https://hexdocs.pm/mongodb/Mongo.html

    * `:allow_disk_use` - Enables writing to temporary files (Default: false)
    * `:collation` - Optionally specifies a collation to use in MongoDB 3.4 and
    * `:max_time` - Specifies a time limit in milliseconds
    * `:use_cursor` - Use a cursor for a batched response (Default: true)
  """
  defmodule Schema do
    @moduledoc false
    use MapSchema,
      atomize: true,
      schema: %{
          :pipeline => :list,

          :allow_disk_use => :bool,
          :collation => :any,
          :max_time => :integer,
          :use_cursor => :bool
     }
  end

  alias MongoAgile.BuilderQueries.Macros.Generic
  defmacro __using__(_opts) do
    quote do
      import MongoAgile.BuilderQueries.AggregateBuilder
    end
  end
  defmacro aggregate(description, keyword) do
    alias MongoAgile.BuilderQueries.AggregateBuilder
    alias MongoAgile.Queries.Aggregate

    Generic.macro_query(description, keyword, AggregateBuilder, Aggregate)
  end

end
