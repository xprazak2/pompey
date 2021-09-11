defmodule Pompey.Routes.Index do
  import Pompey.Routes.Common

  use Plug.Builder
  plug :index

  import OpenApiSpex.Operation, only: [response: 3]
  alias OpenApiSpex.Operation

  def open_api_operation(_) do
    %Operation{
      tags: ["routes"],
      summary: "List routes",
      description: "List all routes",
      responses: %{ 200 => response( "List of routes", "application/json", Pompey.Schemas.RoutesResponse) }
    }
  end

  def index(conn, _opts) do
    conn |> Plug.Conn.send_resp(200, Pompey.Storage.index |> Map.values |> to_resp)
  end
end
