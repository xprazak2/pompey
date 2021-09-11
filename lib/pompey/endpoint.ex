defmodule Pompey.Endpoint do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  require Pompey.Routes.Dynamic

  forward "/pompey", to: Pompey.Routes.Core

  Pompey.Routes.Dynamic.define_routes()

  match "/*path" do
    send_resp(conn, 404, Jason.encode!(%{ error: "No route for /#{path} found" }))
  end
end
