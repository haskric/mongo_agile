IO.puts "Init connection with mongo db testing..."
IO.puts "##   Mongo.start_link in test_helper.exs"
{:ok, _conn} = Mongo.start_link(name: :mongo, database: "test", username: "testbeta", password: "beta", pool_size: 2)

ExUnit.start()
