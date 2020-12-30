defmodule MongoAgile.Queries.Helper.Opts do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      @spec opts(map) :: Keyword.t()
      def opts(query) do
        case apply(__MODULE__, :get_opts, [query]) do
          nil -> []
          opts -> opts
        end
      end

      @spec opts(map, Keyword.t()) :: map
      def opts(query, keyword_opts) do
        apply(__MODULE__, :put_opts, [query, keyword_opts])
      end

      @spec opts_key(map, atom, any) :: map
      def opts_key(query, key, value) when is_atom(key) do
        list_opts = opts(query)
        list_opts = list_opts ++ [{key, value}]

        opts(query, list_opts)
      end
    end
  end

end
