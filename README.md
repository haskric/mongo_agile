# MongoAgile

Mongo Agile Library for Elixir, with a micro-language integrated query

## Installation

```elixir
def deps do
  [
    {:mongo_agile, "~> 0.7.0"}
  ]
end
```
## Usage 

The definition of queries are always in a module, this let us that all queries are organize in controllers that will have multiples queries of a collection.

```elixir 
defmodule Controller do
  use MongoAgile.Controller,
    collection: "test",
    pid_mongo: :mongo

  find_one "get",
    where: %{ "_id" => id }
```

Each query can have dynamic variables. When we run the queries, we will need give the value of the variables using a keyword.

```elixir
Controller.run_query("get",[id: id_mongo])
```

## Usage example:


### Writing queries into Controller

```elixir 
defmodule MongoAgile.Examples.Customer.CustomerController do
  use MongoAgile.Controller,
    collection: "test_customers",
    pid_mongo: :mongo

  find_one "get",
    where: %{ "_id" => id }

  find "get_all", limit: limit

  find "get_active_customers",
    where: %{ "state" => "active" },
    limit: limit

  update "validate",
    set: %{ "$set" => %{ "state" => "active"} },
    where: %{ "$or" => [
      %{ "contact.phone" => %{ "$exists" => true } },
      %{ "contact.email" => %{ "$exists" => true } },
    ]}

  insert_one "create", document: customer
  insert "create_customers", documents: customers

  delete_one "remove",
    where: %{ "_id" => id }

  delete "remove_all",
    where: %{}

end
```

### Run queries

```elixir 
pep = CustomerModel.constructor("Pep","pep@email.com","909 909 909")
{flag, id_mongo} = CustomerController.run_query("create",[customer: pep])
assert flag == :ok

{flag, pep_from_db} = CustomerController.run_query("get",[id: id_mongo])
assert flag == :ok

assert CustomerModel.get_name(pep_from_db) == "Pep"
assert CustomerModel.get_contact_email(pep_from_db) == "pep@email.com"
assert CustomerModel.get_contact_phone(pep_from_db) == "909 909 909"

result = CustomerController.run_query("remove",[id: id_mongo])
assert result == {:ok, "it was deleted"}
```

### Writing model using MapSchema Library

```elixir 
defmodule MongoAgile.Examples.Customer.CustomerModel do

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
```

### Example Schema Versioning & Update:

For each querie we can define the functions `after` and `before`.

```elixir 
def get_before([id: id]) do
  #.. here can adapt the args before of make the query ..

  [id: id]
end

find_one "get",
  where: %{ "_id" => id }

def get_after(result_query) do
  #.. here can adapt the result of query .. 

  result_query
end
```

In this example we are using after and before functions for update schema.

```elixir
defmodule MongoAgile.Examples.Schema.SchemaController do
  use MongoAgile.Controller,
    collection: "test_schema_versioning",
    pid_mongo: :mongo

  alias MongoAgile.Examples.Schema.SchemaModel

  find_one "get",
    where: %{ "_id" => id }

  # When recive a document it´s procesate with the model
  # to adapt the version if it needs.
  def get_after(result_query) do
    case result_query do
      {:ok, doc} ->
        {:ok, SchemaModel.versioning(doc)}
      _otherwise ->
        result_query
    end
  end

  insert_one "create", document: doc

  delete_one "remove", where: %{ "_id" => id }

  replace "replace",
    document: doc,
    where: %{ "_id" => id }

  # .. here others queries ..

end
```

The model check the version, adapt the documents that havent the actual schema and return the documents always with the actual schema that our app it´s waiting. 

```elixir
defmodule MongoAgile.Examples.Schema.SchemaModel do

  use MapSchema,
    schema: %{
        "_id" => :mongo_id,
        "schema_version" => :integer,
        #... here more fields of schema model
    },
    custom_types: %{
      :mongo_id => MongoAgile.MapSchema.IdObjectType
    }

  alias MongoAgile.Examples.Schema.SchemaController

  @schema_version 2

  def versioning(doc) do
   if doc["schema_version"] == @schema_version do
     {:versioning, "ok", doc}
   else
     # Here update version the process of update version

     doc = put_schema_version(doc, @schema_version)

     ## After adapt the schema can make the replace
     Task.start(fn() ->
        SchemaController.run_query("replace", [id: doc["_id"], doc: doc)
     end)

     {:versioning, "updating", doc}
   end
  end

  #... here more functions of model

end
```

## About 

The mission of `:mongo_agile` is create a elixir library that let work easily with MongoDB.

We have create this library using the MongoDB driver for Elixir `:mongodb` and its official documentation. We want thanks the authors, and all contributors of the `:mongodb` for the Great Job!

Sources: 
https://github.com/kobil-systems/mongodb 
https://hexdocs.pm/mongodb/readme.html





