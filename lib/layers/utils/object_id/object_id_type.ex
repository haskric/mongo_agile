defmodule MongoAgile.MapSchema.IdObjectType do

  @behaviour MapSchema.CustomType

  def name, do: :mongo_id
  def nested?, do: false

  @doc """
  Cast string id to bson_id object.

  ## Example:
    iex> MongoAgile.MapSchema.IdObjectType
    iex> str_id = "5feaeb1e10fb18469bbd7336"
    iex> bson_id = BSON.ObjectId.decode!(str_id)
    iex> IdObjectType.cast(str_id)
    bson_id

    iex> MongoAgile.MapSchema.IdObjectType
    iex> bson_id = BSON.ObjectId.decode!("5feaeb1e10fb18469bbd7336")
    iex> IdObjectType.cast(bson_id)
    bson_id

  """
  @spec cast(any) :: any | :error
  def cast(value) when is_bitstring(value) do
    BSON.ObjectId.decode!(value)
  end
  def cast( bson_id = %BSON.ObjectId{}) do
    bson_id
  end
  def cast(_), do: :error


  @doc """
  Check it´s valid id

  ## Example:
    iex> MongoAgile.MapSchema.IdObjectType
    iex> bson_id = BSON.ObjectId.decode!("5feaeb1e10fb18469bbd7336")
    iex> IdObjectType.is_valid?(bson_id)
    true

  """
  @spec is_valid?(any) :: boolean
  def is_valid?(_bson_id = %BSON.ObjectId{}) do
    true
  end
  def is_valid?(_), do: false

  @spec doctest_values :: [{any, any}]
  def doctest_values do
    ["5fdca86a10fb18893febbea0"]
    |> Enum.map(fn(text) ->
      expected = "...> |> MongoAgile.MapSchema.IdObjectType.is_valid?()\n      true\n"

      {"\"#{text}\"", expected}
    end)
  end

end
