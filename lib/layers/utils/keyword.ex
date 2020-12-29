defmodule MongoAgile.MapSchema.KeywordType do
  @moduledoc false

  @behaviour MapSchema.CustomType

  @spec name :: atom
  def name, do: :keyword
  def nested?, do: true

  @spec cast(any) :: any
  def cast(value) do
    value
  end

  @doc """

  ## Example
    iex> alias MongoAgile.MapSchema.KeywordType
    ...> KeywordType.cast([{:key,"value"}])
    ...> |> KeywordType.is_valid?()
    true

    # Without { key, value }
    iex> alias MongoAgile.MapSchema.KeywordType
    ...> KeywordType.cast([:key,"value"])
    ...> |> KeywordType.is_valid?()
    false

  """
  @spec is_valid?(any) :: boolean
  def is_valid?(value) do
    Keyword.keyword?(value)
  end

  @spec doctest_values :: [{any, any}]
  def doctest_values do
    ["{:hola,\"hi\"}"]
    |> Enum.map(fn(item) -> {item, item} end)
  end

end
