defmodule MongoAgile.MixProject do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :mongo_agile,
      version: "0.8.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "mongo_agile",
      source_url: "https://github.com/haskric/mongo_agile",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mongodb, "~> 0.5.1"},
      {:map_schema, ">= 0.0.0"},

      # mix docs
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},

      ## MIX_ENV=test mix coveralls.html
      {:excoveralls, "~> 0.10", only: :test},

      ## mix credo
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  def docs do
    [
      main: "readme",
      extras: [
        "README.md"
      ]
    ]
  end

  defp description do
    "Mongo Agile Library for Elixir, with a micro-language integrated query"
  end

  defp package do
    [
      files: [
        "lib",
        "LICENSE",
        "mix.exs",
        "README.md"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/haskric/mongo_agile"}
    ]
  end
end
