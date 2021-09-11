defmodule Pompey.Routes.Index do
  import Pompey.Routes.Common

  use Plug.Builder
  # alias Pompey.Storage

  plug :index

  def index(conn, _opts) do
    conn |> Plug.Conn.send_resp(200, Pompey.Storage.index |> to_resp)
  end
end
