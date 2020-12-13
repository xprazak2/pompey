defmodule Pompey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Pompey.Worker.start_link(arg)
      # {Pompey.Worker, arg}
      {Pompey.Storage, name: Pompey.Storage},
      {Plug.Cowboy, scheme: :http, plug: Pompey.Endpoint, options: [port: Application.get_env(:pompey, :port)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pompey.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
