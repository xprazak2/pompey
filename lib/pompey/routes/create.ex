defmodule Pompey.Routes.Create do
  import Pompey.Routes.Common

  use Plug.Builder
  plug :create

  import OpenApiSpex.Operation, only: [response: 3, request_body: 4]
  alias OpenApiSpex.Operation

  def open_api_operation(_) do
    %Operation{
      tags: ["routes"],
      summary: "Create a route",
      description: "Create a route",
      requestBody: request_body("Route attributes", "application/json", Pompey.Schemas.RouteRequest, required: true),
      responses: %{
        201 => response("Route", "application/json", Pompey.Schemas.RouteResponse),
        422 => response("Error", "application/json", Pompey.Schemas.RouteCreateError)
      }
    }
  end


  def create(conn, _opts) do
    case conn.params |> from_params do
       nil -> conn |> Plug.Conn.send_resp(422, %{error: "Invalid params for new route, expected format: { route: { ...attributes } }" } |> to_resp)
       {:ok, route} -> conn |> handle_create(route)
       {:error, error} -> conn |> send_resp(422, error |> to_error)
    end
  end

  defp handle_create(conn, new_route) do
    case new_route |> Pompey.Storage.create do
      {:ok, route} -> conn |> Plug.Conn.send_resp(201, route |> to_resp)
      {:error, reason} -> conn |> Plug.Conn.send_resp(422, reason |> to_error)
    end
  end

  defp from_params(%{"route" => route_params }) do
    route_params |> Pompey.Route.from_params
  end
  defp from_params(_) do
    nil
  end
end
