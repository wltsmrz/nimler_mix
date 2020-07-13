
defmodule Nimler.MixProject do
  use Mix.Project

  def project() do
    [
      app: :nimler,
      version: "0.1.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Nimler",
      source_url: "https://github.com/wltsmrz/nimler_hex"
    ]
  end

  def application() do
    []
  end

  defp deps() do
    []
  end

  defp description() do
    "Nimler nif helpers"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/wltsmrz/nimler_hex"
      }
    ]
  end
end
