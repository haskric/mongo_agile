defmodule MongoAgile.Queries.Helper.Update do
  @moduledoc """

  Info origin:  https://docs.mongodb.com/manual/reference/operator/update/

  Name	Description
  $currentDate	Sets the value of a field to current date, either as a Date or a Timestamp.
  $inc	Increments the value of the field by the specified amount.
  $min	Only updates the field if the specified value is less than the existing field value.
  $max	Only updates the field if the specified value is greater than the existing field value.
  $mul	Multiplies the value of the field by the specified amount.
  $rename	Renames a field.
  $set	Sets the value of a field in a document.
  $setOnInsert	Sets the value of a field if an update results in an insert of a document. Has no effect on update operations that modify existing documents.
  $unset	Removes the specified field from a document.

  """

  use MapSchema,
  type_name: "<query_update>",
  schema: %{
      "$currentDate" => :map,
      "$inc" => :map,
      "$min" => :map,
      "$max" => :map,
      "$mul" => :map,
      "$rename" => :map,
      "$set" => :map,
      "$setOnInsert" => :map,
      "$unset" => :map,
      "$addToSet" => :map,
      "$pop" => :map,
      "$pull" => :map,
      "$push" => :map,
      "$pullAll" => :map,
      "$bit" => :map
  }

  defmacro __using__(_opts) do

    quote do

      @spec update(map) :: map
      def update(query) do
        case apply(__MODULE__, :get_update, [query]) do
          nil -> %{}
          update -> update
        end
      end

      @spec update(map, map) :: map
      def update(query, update) when is_map(update) do
        apply(__MODULE__, :put_update, [query, update])
      end

    end

  end

end
