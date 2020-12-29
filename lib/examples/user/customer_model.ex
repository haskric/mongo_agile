defmodule MongoAgile.Examples.Customer.CustomerModel do

  use MapSchema,
    schema: %{
        "_id" => :any,
        "name" => :string,
        "contact" => %{
          "email" => :string,
          "phone" => :string
        },
        "state" => :string
    }

  def constructor(name, email, phone) do
    new()
    |> put_name(name)
    |> put_contact_email(email)
    |> put_contact_phone(phone)
    |> put_state("active")
  end




end
