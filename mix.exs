defmodule ExSemiLattice.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_semi_lattice,
      aliases: aliases(),
      deps: deps(),
      preferred_cli_env: [quality: :test],

      # Versions
      version: "0.0.1",
      elixir: "~> 1.9",

      # Docs
      #name: "ExSemiLattice",
      #docs: docs(),

      # Hex
      description: "Semi-Lattice using Witchcraft",
      package: package()
    ]
  end

  defp aliases do
    [
      quality: [
          "test",
          "credo --strict"
        ]
    ]
  end

  defp deps do
    [
      {:ex_doc,      "~> 0.23", only: :dev,                 runtime: false},
      {:witchcraft, "~> 1.0"},
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/hosh/ex_semi_lattice"},
      maintainers: ["Ho-Sheng Hsiao"]
    ]
  end
end
