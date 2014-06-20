defmodule Exquisite.Mixfile do
  use Mix.Project

  def project do
    [ app: :exquisite,
      version: "0.1.2",
      elixir: "~> 0.14.1",
      package: package,
      description: "DSL to match_spec" ]
  end

  defp package do
    [ contributors: ["meh"],
      licenses: ["WTFPL"],
      links: [ { "GitHub", "https://github.com/meh/exquisite" } ] ]
  end
end
