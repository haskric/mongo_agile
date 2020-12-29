defmodule MongoAgile.BuilderQueries.Builder do

  def into(keyword, module_model) do
    map = Enum.into(keyword,%{})
    apply(module_model, :put, [map])
  end

  def build(query, model_attrs, module) do
    model_attrs
    |> Map.keys()
    |> Enum.reduce(query, fn(key, acc_query) ->
      value = Map.get(model_attrs, key)

      acc_query
      |> add_attr(key, value, module)
    end)
  end


  @options_keys [
    :limit,
    :comment,
    :cursor_type,
    :max_time,
    :modifiers,
    :cursor_timeout,
    :sort,
    :projection,
    :skip,
    :upsert,
    :continue_on_error,
    :ordered
  ]

  defp add_attr(acc_query, :where, value, module) do
    apply(module, :selector, [acc_query, value])
  end
  defp add_attr(acc_query, :set, value, module) do
    apply(module, :update, [acc_query, value])
  end
  defp add_attr(acc_query, :document, value, module) do
    apply(module, :doc, [acc_query, value])
  end
  defp add_attr(acc_query, :documents, value, module) do
    apply(module, :docs, [acc_query, value])
  end
  defp add_attr(acc_query, key, value, module) when key in @options_keys do
    apply(module,:opts_key,[acc_query, key, value])
  end

  # Using mapSchemas in macros, this case never should be happen
  # defp add_attr(acc_query, _key, _value, _module) do
  #   acc_query
  # end

end
