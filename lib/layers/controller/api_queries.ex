defmodule MongoAgile.Controller.ApiQueries do

  def install_api(true) do
    quote do

      def get(id) do
        args = [id: id]
        apply(__MODULE__, :run_query, ["get",args])
      end

      find_one "get", where: %{ "_id" => id }


      def post(doc) do
        args = [doc: doc]
        apply(__MODULE__, :run_query, ["post",args])
      end

      insert_one "post", document: doc

      def put(id, doc) do
        args = [id: id, doc: doc]
        apply(__MODULE__, :run_query, ["put",args])
      end

      replace "put",
        where: %{ "_id" => id },
        document: doc

      def delete(id) do
        args = [id: id]
        apply(__MODULE__, :run_query, ["delete",args])
      end

      delete_one "delete", where: %{ "_id" => id }

      def patch(id, changeset) do
        args = [id: id, changeset: changeset]
        apply(__MODULE__, :run_query, ["patch",args])
      end

      update_one "patch",
        set: %{ "$set" => changeset },
        where: %{ "_id" => id }

    end
  end
  def install_api(_) do
    []
  end

end
