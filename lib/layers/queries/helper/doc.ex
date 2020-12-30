defmodule MongoAgile.Queries.Helper.Doc do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @spec doc(map) :: map
      def doc(query) do
        case apply(__MODULE__, :get_doc, [query]) do
          nil -> %{}
          doc -> doc
        end
      end

      @spec doc(map, map) :: map
      def doc(query, doc) when is_map(doc) do
        apply(__MODULE__, :put_doc, [query, doc])
      end
    end
  end

end
