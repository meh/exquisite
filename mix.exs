defmodule Exquisite.Mixfile do
  use Mix.Project

  def project do
    [ app: :exquisite,
      version: "0.1.0",
      elixir: "~> 0.13.2-dev",
      package: package,
      description: "DSL to match_spec" ]
  end

  defp package do
    [ contributors: ["meh"],
      licenses: ["WTFPL"],
      links: [ { "GitHub", "https://github.com/meh/exquisite" } ] ]
  end
end
