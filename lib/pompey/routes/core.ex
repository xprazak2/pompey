defmodule Pompey.Routes.Core do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Logger, log: :debug
  plug OpenApiSpex.Plug.PutApiSpec, module: Pompey.ApiSpec
  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason
  plug :dispatch

  get "/openapi", to: OpenApiSpex.Plug.RenderSpec
  get "/swaggerui", to: OpenApiSpex.Plug.SwaggerUI, init_opts: [path: "/pompey/openapi"]

  get "/", to: Pompey.Routes.Index
  post "/", to: Pompey.Routes.Create

  match "/*path" do
    send_resp(conn, 404, %{ error: "Not found" } |> Jason.encode!)
  end
end
