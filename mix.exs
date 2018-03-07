defmodule Panex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :panex,
      name: "Panex",
      version: "0.1.0",
      elixir: "~> 1.2",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
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
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description do
    """
    An utility library for Elixir
    """
  end

  defp package do
    [
      licenses: ["MIT License"],
      maintainers: ["vthang95"],
      links: %{"Github" => "https://github.com/vthang95/panex"}
    ]
  end
end
