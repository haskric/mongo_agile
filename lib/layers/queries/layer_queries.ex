defmodule MongoAgile.Queries do
  defmacro __using__(_opts) do

    quote do

      # Find
      alias MongoAgile.Queries.FindOne
      alias MongoAgile.Queries.Find

      # Insert
      alias MongoAgile.Queries.InsertOne
      alias MongoAgile.Queries.InsertMany

      # Update
      alias MongoAgile.Queries.UpdateOne
      alias MongoAgile.Queries.UpdateMany

      # Delete
      alias MongoAgile.Queries.DeleteOne
      alias MongoAgile.Queries.DeleteMany

      # Query execution
      import MongoAgile.Queries.AgilQuery

    end

  end

end
