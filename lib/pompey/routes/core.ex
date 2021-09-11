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
    # send_resp(conn, 200, conn.body_params |> create_route)
    new_route = from_params conn.params
    # require IEx; IEx.pry
    case new_route do
       nil -> send_resp(conn, 422, %{error: "Invalid params for new route, expected format: { route: { ...attributes } }"} |> to_resp)
       {:ok, route} -> send_resp(conn, 201, new_route |> create_route |> to_resp)
       {:error, error} -> send_resp(conn, 422, error |> to_error)
    end
  end

  match _ do
    send_resp(conn, 404, Jason.encode!(%{ error: "I draw blank" }))
  end

  defp to_resp(data) do
    Jason.encode!(%{ result: data })
  end

  defp to_error(data) do
    Jason.encode!(%{ error: data })
  end

  defp from_params(%{"route" => route_params } = params) do
    Pompey.Route.from_params route_params
  end
  defp from_params(_) do
    nil
  end

  defp create_route(new_route) do
    Storage.create new_route
  end
end
