defmodule MongoAgile.Examples.Customer.CustomerModel do
  @moduledoc """
  CustomerModel Example of model using MapSchema
  """

  use MapSchema,
    schema: %{
        "_id" => :mongo_id,
        "name" => :string,
        "contact" => %{
          "email" => :string,
          "phone" => :string
       },
        "state" => :string
   },
    custom_types: %{
      :mongo_id => MongoAgile.MapSchema.IdObjectType
   }

  def constructor(name, email, phone) do
    new()
    |> put_name(name)
    |> put_contact_email(email)
    |> put_contact_phone(phone)
    |> put_state("active")
  end

end
