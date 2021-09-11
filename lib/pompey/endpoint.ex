defmodule Pompey.Endpoint do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  require Pompey.Routes.Dynamic
  alias Pompey.Routes.Dynamic

  Dynamic.define_routes()

  forward "/pompey", to: Pompey.Routes.Core

  match "/*path" do
    send_resp(conn, 404, Jason.encode!(%{ error: "No route for /#{path} found" }))
  end
end
