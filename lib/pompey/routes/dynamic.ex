defmodule Pompey.Routes.Dynamic do
  import Plug.Conn, only: [send_resp: 3]

  defmacro define_routes do
    routes_ast = Pompey.FileStorage.safe_load |> Enum.map(&build_ast/1)

    quote do
      unquote_splicing(routes_ast)
    end
  end

  def build_ast(route) do
    escaped_route = route |> Macro.escape
    quote do
      match(unquote(route.path), via: unquote(String.to_atom route.method)) do
        Pompey.Routes.Dynamic.forward_dynamic_route(var!(conn), unquote(escaped_route))
      end
    end
  end

  def forward_dynamic_route(conn, route) do
    case HTTPoison.request(String.to_atom(route.method), route.url) do
      {:ok, response} -> respond_for_success(conn, route, response)
      {:error, error} -> respond_for_error(conn, route, error)
    end
  end

  defp respond_for_success(conn, route, response) do
    respond conn, route, response
  end

  defp respond_for_error(conn, route, error) do
    respond conn, route, error
  end

  defp respond(conn, _route, response) do
    send_resp(conn, response.status_code, response.body)
  end
end
