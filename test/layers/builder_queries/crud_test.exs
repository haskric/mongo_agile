defmodule MongoAgile.BuilderQueries.CRUD.Test do
  use ExUnit.Case

  defmodule ViewsPage do
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_views_page",
      pid_mongo: :mongo


    use MapSchema,
      schema: %{
          "title" => :string,
          "views" => :integer,
      }

    find_one "get_page",
      where: %{ "_id" => id }

    insert_one "insert_page", document: doc

    update_one "inc_visit",
      set: %{"$inc" => %{ "views" => 1 }},
      where: %{ "_id" => id }

    update_one "set_title",
      set: %{"$set" => %{ "title" => title }},
      where: %{ "_id" => id }

    delete_one "delete_page",
      where: %{ "_id" => id }

    replace "replace_or_insert",
      where: %{ "_id" => id },
      document: doc,
      upsert: true

  end


  test "Insert, Update $inc, $set, find and delete" do

    original_doc = %{ "title"=> "hello world", "views" => 0}

    result = ViewsPage.run_query("insert_page",[doc: original_doc])

    {flag, id_mongo} = result
    assert flag == :ok

    result = ViewsPage.run_query("set_title",[
      id: id_mongo,
      title: "Hello W0rld, Mongo Agilers.."
    ])
    assert result == {:ok, "updated"}

    result = ViewsPage.run_query("inc_visit",[id: id_mongo])
    assert result == {:ok, "updated"}

    result = ViewsPage.run_query("get_page",[id: id_mongo])

    {flag, doc} = result
    assert flag == :ok

    doc = doc
      |> Map.delete("_id")

    expected_doc = %{ "title"=> "Hello W0rld, Mongo Agilers..", "views" => 1}
    assert doc == expected_doc

    result = ViewsPage.run_query("delete_page",[id: id_mongo])
    assert result == {:ok, "it was deleted"}

  end

  test "replace" do

    original_doc = %{
      "_id" => "hola",
      "title"=> "hello world",
      "views" => 10
    }

    {:ok, ["hola"]} = ViewsPage.run_query("replace_or_insert",[id: "hola", doc: original_doc])


    {:ok, doc} = ViewsPage.run_query("get_page",[id: "hola"])
    assert doc == original_doc

    result = ViewsPage.run_query("delete_page",[id: "hola"])
    assert result == {:ok, "it was deleted"}

  end

end
