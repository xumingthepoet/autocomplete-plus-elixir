defmodule Autocompletion.Mixfile do
  use Mix.Project

  def project do
    [app: :autocompletion,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :elli],
     mod: {:autocompletion, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:elli, [git: "git://github.com/knutin/elli.git"]},
    {:exrm, "~> 0.14.10"}]
  end
end
