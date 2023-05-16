defmodule WithOnnx.MixProject do
  use Mix.Project

  def project do
    [
      app: :with_onnx,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      config: [nx: [default_backend: EXLA.Backend]]
      #system_env: %{"XLA_TARGET" => xla_target}
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
      {:nx, "~> 0.3"},
      {:axon, "~> 0.2"},
      {:exla, "~> 0.3"},
      {:axon_onnx, "~> 0.2"},
      {:stb_image, "~> 0.5"},
      {:kino, "~> 0.7.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
