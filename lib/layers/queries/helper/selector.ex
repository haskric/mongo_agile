defmodule MongoAgile.Queries.Helper.Selector do

  defmacro __using__(_opts) do

    quote do
      alias MongoAgile.Queries.Helper.Selector

      @spec selector(map) :: map
      def selector(query) do
        case apply(__MODULE__, :get_selector, [query]) do
          nil -> %{}
          selector -> selector
        end
      end

      @spec selector(map, map) :: map
      def selector(query, selector_map) when is_map(selector_map) do
        apply(__MODULE__, :put_selector, [query, selector_map])
      end

      @spec select_field(map, binary, any) :: map
      def select_field(query, field, value) do
        selector_map = selector(query)
          |> Map.put(field, value)

        selector(query, selector_map)
      end

    end

  end



end
