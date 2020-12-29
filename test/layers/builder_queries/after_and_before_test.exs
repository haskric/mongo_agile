defmodule MongoAgile.BuilderQueries.AfterAndBefore.Test do
  use ExUnit.Case

  defmodule Measure do
    import MongoAgile.Queries.AgilQuery
    use MongoAgile.BuilderQueries,
      collection: "test_measures",
      pid_mongo: :mongo

      def find_by_category_before([category: category]) do
        throw "Error_in_before"

        [category: category]
      end

    find "find_by_category",
      where: %{ "category" => category }


    find "find_by_section",
        where: %{ "section" => section }

      def find_by_section_after(result) do
        throw "Error_in_after"

        result
      end
  end

  test "error_in_before" do
    try do
      Measure.run_query("find_by_category",[category: "CRUDMany"])

      assert false
    catch
      e ->
        assert e == {:execution_error, :find_by_category_before , "Error_in_before"}
    end
  end

  test "error_in_after" do
    try do
      Measure.run_query("find_by_section",[section: "UNKNOW"])

      assert false
    catch
      e ->
        assert e == {:execution_error, :find_by_section_after , "Error_in_after"}
    end
  end

end
