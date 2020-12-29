defmodule MongoAgile.BuilderQueries do

  defmacro __using__(opts) do
    collection = Keyword.get(opts, :collection)
    pid_mongo = Keyword.get(opts, :pid_mongo)

    quote bind_quoted: [
      collection: collection,
      pid_mongo: pid_mongo]
    do

      @pid_mongo pid_mongo
      @collection collection

      use MongoAgile.BuilderQueries.FindBuilder
      use MongoAgile.BuilderQueries.FindOneBuilder

      use MongoAgile.BuilderQueries.UpdateOneBuilder
      use MongoAgile.BuilderQueries.UpdateManyBuilder

      use MongoAgile.BuilderQueries.InsertOneBuilder
      use MongoAgile.BuilderQueries.InsertManyBuilder

      use MongoAgile.BuilderQueries.DeleteOneBuilder
      use MongoAgile.BuilderQueries.DeleteManyBuilder

      use MongoAgile.BuilderQueries.ReplaceOneBuilder

      @doc """

      """
      def run_query(name, args) do
        name_fn = String.to_atom("#{name}_query_run")
        apply(__MODULE__, name_fn, [args])
      end
    end
  end

  @callback run_query(query :: map) :: {:ok, any} | {:error, any}

end
