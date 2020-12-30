defmodule MongoAgile.Queries.Helper.DocList do
  @moduledoc false

  defmacro __using__(_opts) do

    quote do

      @spec docs(map) :: [map]
      def docs(query) do
        case apply(__MODULE__, :get_docs, [query]) do
          nil -> []
          docs -> docs
        end
      end

      @spec docs(map, [map]) :: map
      def docs(query, docs) when is_list(docs) do
        apply(__MODULE__, :put_docs, [query, docs])
      end

      @spec docs_add(map, map) :: map
      def docs_add(query, doc) when is_map(doc) do
        list_docs = docs(query)
        list_docs = list_docs ++ [doc]

        docs(query, list_docs)
      end

    end

  end

end
