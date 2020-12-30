defmodule MongoAgile.Examples.Customer.CustomerController do
  @moduledoc """
  CustomerController Example of queries
  """
  use MongoAgile.Controller,
    collection: "test_customers",
    pid_mongo: :mongo

  find_one "get",
    where: %{"_id" => id}

  find "get_all", limit: limit

  find "get_active_customers",
    where: %{"state" => "active"},
    limit: limit

  update "validate",
    set: %{"$set" => %{"state" => "active"}},
    where: %{"$or" => [
      %{"contact.phone" => %{"$exists" => true}},
      %{"contact.email" => %{"$exists" => true}},
    ]}

  insert_one "create", document: customer
  insert "create_customers", documents: customers

  delete_one "remove",
    where: %{"_id" => id}

  delete "remove_all",
    where: %{}

end
