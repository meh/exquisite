defmodule Exquisite.Mixfile do
  use Mix.Project

  def project do
    [ app: :exquisite,
      version: "0.1.7",
      package: package(),
      description: "DSL to match_spec" ]
  end

  defp package do
    [ maintainers: ["meh"],
      licenses: ["WTFPL"],
      links: %{"GitHub" => "https://github.com/meh/exquisite"} ]
  end
end
