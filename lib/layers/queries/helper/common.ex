defmodule MongoAgile.Queries.Helper.Common do
  @moduledoc false

  defmacro __using__(_opts) do

    quote do
      @type common_result :: {:ok, any} | {:error, any}

      @spec exe(map) :: {:ok, any} | {:error, any}
      def exe(query) do
        run(query)
        |> return()
      rescue
        e ->
          {:error, e}
      catch
        e ->
          {:error, e}
      end

    end

  end

  @type common_result :: {:ok, any} | {:error, any}

  @callback run(query :: map) :: any
  @callback return(query_result :: any) :: common_result

end
