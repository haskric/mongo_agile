defmodule MongoAgile.Queries.Helper.Base do
  @moduledoc false
  use MapSchema,
    type_name: "<query_base>",
    atomize: true,
    schema: %{
        :query_name => :string,
        :pid_mongo => :any,
        :collection => :string
   }

  @spec from(String.t(), String.t(), atom | :pid ) :: map
  def from(query_name, collection, pid_mongo) do
    new()
    |> put_query_name(query_name)
    |> put_pid_mongo(pid_mongo)
    |> put_collection(collection)
  end

  @spec base_from(String.t(), String.t()) :: map
  def base_from(query_name, collection) do
    base_from(query_name, collection, :mongo)
  end

  @spec base_from(String.t(), String.t(), atom | :pid) :: map
  def base_from(query_name, collection, pid_mongo) do
    query_base = from(query_name, collection, pid_mongo)

    new()
    |> Map.put(:base, query_base)
  end

  defmacro __using__(opts) do
    name = Keyword.get(opts, :name)

    quote bind_quoted: [name: name] do
      @query_name name

      alias MongoAgile.Queries.Helper.Base

      @spec from(String.t()) :: map
      def from(collection) do
        Base.base_from(@query_name, collection)
      end

      @spec from(String.t(), pid | atom) :: map
      def from(collection, pid_mongo) do
        Base.base_from(@query_name, collection, pid_mongo)
      end

      @spec pid_mongo(map) :: pid | atom
      def pid_mongo(query) do
        query.base.pid_mongo
      end

      @spec collection(map) :: String.t()
      def collection(query) do
        query.base.collection
      end

    end

  end

end
