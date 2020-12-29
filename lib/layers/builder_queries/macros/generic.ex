defmodule MongoAgile.BuilderQueries.Macros.Generic do
  alias MongoAgile.BuilderQueries.Builder
  alias MongoAgile.BuilderQueries.Macros.Generic

  def macro_query(name, keyword, module_builder, module_query) do
    [
      macro_map_query(name, keyword, module_builder, module_query),
      macro_run_query(name)
    ]
  end


  defp macro_map_query(name, keyword, module_builder, module_query) do
    str_keyword = Macro.to_string(keyword)
    quote bind_quoted: [
      name: name,
      str_keyword: str_keyword,
      module_builder: module_builder,
      module_query: module_query]
    do
      name_query = String.to_atom("#{name}_query")
      module_builder = Module.concat([module_builder,Schema])
      @doc """
      Build the query '#{name_query}'
      """
      def unquote(name_query)(var!(args)) do
        {keyword, _} = Code.eval_string(unquote(str_keyword), var!(args), __ENV__)
        model_attrs = Builder.into(keyword, unquote(module_builder))

        apply(unquote(module_query), :from, [@collection, @pid_mongo])
        |> Builder.build(model_attrs, unquote(module_query))
      end
    end
  end

  defp macro_run_query(name) do
    quote bind_quoted: [name: name] do
      name_query = String.to_atom("#{name}_query")
      name_run_query = String.to_atom("#{name}_query_run")

      @doc """
      Execute the query '#{name_query}'

      ## Pipeline of execution:

        #{name}_before(args) # Optional
        |> #{name}_query()
        |> run_query()
        |> #{name}_after() # Optional

      """
      def unquote(name_run_query)(var!(args)) do
        Generic.generic_before(var!(args), unquote(name), __MODULE__)
        |> unquote(name_query)()
        |> run_query()
        |> Generic.generic_after(unquote(name), __MODULE__)
      end
    end
  end


  def generic_before(args, name, module) do
    name_before = String.to_atom("#{name}_before")

    if Kernel.function_exported?(module, name_before, 1) do
      try do
        apply(module, name_before, [args])
      catch
        e ->
          throw {:execution_error, name_before, e}
      end
    else
      args
    end
  end

  def generic_after(result, name, module) do
    name_after = String.to_atom("#{name}_after")

    if Kernel.function_exported?(module, name_after, 1) do
      try do
        apply(module, name_after, [result])
      catch
        e ->
          throw {:execution_error, name_after, e}
      end
    else
      result
    end
  end

end
