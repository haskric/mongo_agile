defmodule MongoAgile.Queries do
  @moduledoc false
  defmacro __using__(_opts) do

    quote do

      # Find
      alias MongoAgile.Queries.Find
      alias MongoAgile.Queries.FindOne

      # Insert
      alias MongoAgile.Queries.InsertMany
      alias MongoAgile.Queries.InsertOne

      # Update
      alias MongoAgile.Queries.UpdateMany
      alias MongoAgile.Queries.UpdateOne

      # Delete
      alias MongoAgile.Queries.DeleteMany
      alias MongoAgile.Queries.DeleteOne

      #Replace
      alias MongoAgile.Queries.ReplaceOne

      #Count
      alias MongoAgile.Queries.CountDocuments

      alias MongoAgile.Queries.Aggregate

      # Query execution
      import MongoAgile.Queries.AgilQuery

    end

  end

end
