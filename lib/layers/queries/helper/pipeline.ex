defmodule MongoAgile.Queries.Helper.Pipeline do
  @moduledoc false
  defmacro __using__(_opts) do

    quote do
      @spec pipeline(map) :: [map]
      def pipeline(query) do
        case apply(__MODULE__, :get_pipeline, [query]) do
          nil -> []
          pipeline -> pipeline
        end
      end

      @spec pipeline(map, [map()]) :: map
      def pipeline(query, pipeline_map) do
        apply(__MODULE__, :put_pipeline, [query, pipeline_map])
      end

    end
  end

end
