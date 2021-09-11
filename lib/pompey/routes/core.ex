defmodule Pompey.Routes.Core do
  use Plug.Router
  use Plug.Debugger

  alias Pompey.Storage

  plug Plug.Logger, log: :debug
  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason
  plug :dispatch

  get "/" do
    send_resp(conn, 200, Storage.index |> to_resp)
  end

  post "/" do
    case conn.params |> from_params do
       nil -> send_resp(conn, 422, %{error: "Invalid params for new route, expected format: { route: { ...attributes } }" } |> to_resp)
       {:ok, route} -> handle_create(conn, route)
       {:error, error} -> send_resp(conn, 422, error |> to_error)
    end
  end

  match "/*path" do
    send_resp(conn, 404, %{ error: "Not found" } |> Jason.encode!)
  end

  defp to_resp(data) do
    %{ result: data } |> Jason.encode!
  end

  defp to_error(data) do
    %{ error: data } |> Jason.encode!
  end

  defp handle_create(conn, new_route) do
    case new_route |> create_route do
      {:ok, route} -> send_resp(conn, 201, route |> to_resp)
      {:error, reason} -> send_resp(conn, 422, reason |> to_error)
    end
  end

  defp from_params(%{"route" => route_params }) do
    route_params |> Pompey.Route.from_params
  end
  defp from_params(_) do
    nil
  end

  defp create_route(new_route) do
   new_route |>  Storage.create
  end
end
