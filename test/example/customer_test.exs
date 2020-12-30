defmodule MongoAgile.Examples.Customer.Test do
  @moduledoc false
  use ExUnit.Case
  doctest MongoAgile.Examples.Customer.CustomerModel
  alias MongoAgile.Examples.Customer.CustomerController
  alias MongoAgile.Examples.Customer.CustomerModel

  test "create customer, get and remove it" do

    pep = CustomerModel.constructor("Pep", "pep@email.com", "909 909 909")
    {flag, id_mongo} = CustomerController.run_query("create", [customer: pep])
    assert flag == :ok

    {flag, pep_from_db} = CustomerController.run_query("get", [id: id_mongo])
    assert flag == :ok

    assert CustomerModel.get_name(pep_from_db) == "Pep"
    assert CustomerModel.get_contact_email(pep_from_db) == "pep@email.com"
    assert CustomerModel.get_contact_phone(pep_from_db) == "909 909 909"

    result = CustomerController.run_query("remove", [id: id_mongo])
    assert result == {:ok, "it was deleted"}

  end

  test "create list customer, update, and remove it" do

    result = CustomerController.run_query("remove_all", [])
    assert result == {:error, "they wasnt found"}

    list_customers = [
      %{"name" => "Mary"},
      %{"name" => "Bob", "contact" => %{"email" => "bob@bobemail.com"}},
      %{"name" => "Karl"},
      %{"name" => "Tomas"},
      %{"name" => "Julia", "contact" => %{"email" => "example@example.com"}},
    ]

    {flag, _list_id_mongo} = CustomerController.run_query("create_customers", [customers: list_customers])
    assert flag == :ok

    {flag, db_list_customers} = CustomerController.run_query("get_all", [limit: 10])
    assert flag == :ok

    # Remove ID mongo for can check the list
    db_list_customers = db_list_customers
      |> Enum.map(fn(customer) -> Map.delete(customer, "_id")  end)

    assert db_list_customers == list_customers

    result = CustomerController.run_query("validate", [])
    assert result == {:ok, "they was updated"}

    {flag, db_list_customers} = CustomerController.run_query("get_active_customers", [limit: 10])
    assert flag == :ok

    # Remove ID mongo for can check the list
    db_list_customers = db_list_customers
    |> Enum.map(fn(customer) -> Map.delete(customer, "_id")  end)

    assert db_list_customers == [
      %{"name" => "Bob", "contact" => %{"email" => "bob@bobemail.com"}, "state" => "active"},
      %{"name" => "Julia", "contact" => %{"email" => "example@example.com"}, "state" => "active"},
    ]

    result = CustomerController.run_query("remove_all", [])
    assert result == {:ok, "they was deleted"}

  end

end
